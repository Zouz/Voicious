###

Copyright (c) 2011-2012  Voicious

This program is free software: you can redistribute it and/or modify it under the terms of the
GNU Affero General Public License as published by the Free Software Foundation, either version
3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this
program. If not, see <http://www.gnu.org/licenses/>.

###

Request     = require 'request'
nodemailer  = require 'nodemailer'
moment      = require 'moment'

Config      = require '../common/config'
{Session}   = require './session'
{Errors}    = require './errors'
{Token}     = require './token'
{Translator}= require './trans'
class _Room
        constructor : () ->
            @transport = nodemailer.createTransport('Sendmail');
            @token  = Token

        renderRoom : (res, options, host) =>
            options.trans = Translator.getTrans(host, 'room')
            res.render 'room', options

        roomPage : (req, res, next) =>
            Request.get "#{Config.Restapi.Url}/room/#{req.params.roomid}", (e, r, body) =>
                if e? or r.statusCode > 200
                    Errors.RenderNotFound req, res
                else
                    user          = req.currentUser
                    options       =
                            title   : 'Voicious'
                            login   : user.name
                            room    : req.params.roomid
                            wsHost  : Config.Websocket.Hostname.External
                            wsPort  : Config.Websocket.Port
                    user.id_room = req.params.roomid
                    Request.put {
                        json    : user
                        url     : "#{Config.Restapi.Url}/user/#{user.id}"
                    }, (e, r, body) =>
                        if e? or r.statusCode > 200
                            throw new Errors.Errors
                        else
                            @token.createToken user.id, req.params.roomid,
                                (token) =>
                                    options.token = token
                                    @renderRoom res, options, req.host

        reportBug       : (req, res) =>
            @transport.sendMail({
                from    : "Voicious bugs<no-reply@voicious.com>"
                to      : 'voicious_2014@labeip.epitech.eu'
                subject : 'Bug Report ' + moment().format()
                text    : req.body.bug})
            Request.post {
                json    : req.body
                url     : "#{Config.Restapi.Url}/bug"
            }, (e, r, body) =>
                if e? or r.statusCode > 200
                    throw new Errors.Error
                else
                    res.send 200

        newRoom : (req, res, param) =>
            Request.post {
                json    : param
                url     : "#{Config.Restapi.Url}/room"
            }, (e, r, body) =>
                if e? or r.statusCode > 200
                    throw new Errors.Error
                else
                    res.redirect "/room/#{body.id}"

        redirectRoom : (req, res) =>
            if req.params.roomid?
                res.redirect "/?roomid=#{req.params.roomid}&hash=#jumpIn"

exports.Room    = new _Room
exports.Routes  =
    get :
        '/room/:roomid' : (Session.ifUser.curry exports.Room.roomPage, exports.Room.redirectRoom)
    post :
        '/report'       : exports.Room.reportBug
