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

ModelDef =
    name    :
        type    : String
        length  : 40
        index   : true
    mail    :
        type    : String
        length  : 40
    password:
        type    : String
        length  : 255
    id_room:
        type    : String
        length  : 255
    id_acl  :
        type    : Number
    id_role :
        type    : Number
    c_date  :
        type    : Date
        default : Date.now
    last_con    :
        type    : Date

AfterModelDef   = (m) =>
    m.validatesPresenceOf 'name', 'mail'

exports.ModelDef        = ModelDef
exports.AfterModelDef   = AfterModelDef
