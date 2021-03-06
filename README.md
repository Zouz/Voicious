# Voicious

Voicious is an open source web application allowing everyone to enjoy video conferencing.
Aimed as well for private using than for enterprises, its ease of use and its ergonomy are its main strengths.

## Install

Run the following command from the root directory to install Voicious' dependencies :
<pre><code>npm install</code></pre>

Otherwise, you can manually install all dependencies and run :
<pre><code>cake build</code></pre>

## Run

Run one of the following commands from the root directory to run the Voicious server :  
<pre><code>npm start
node ./lib/startup.js</code></pre>

## Dependencies

The Voicious server requires the following Node.js modules to run :

* Express (=> 3.x)
* Jade (>= 0.27.x)
* JugglingDB (>= 0.1.x)
* MD5 (>= 1.0x)
* Moment (>= 2.0.0)
* Request (>= 2.12.0)


To build Voicious you will also need a working CoffeeScript installation  
To build Voicious' documentation, you will also need Docco and Pygments

## Licensing

Copyright &copy; 2011-2012  Voicious

This program is free software: you can redistribute it and/or modify it under the terms of the
GNU Affero General Public License as published by the Free Software Foundation, either version
3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this
program. If not, see <http://www.gnu.org/licenses/>.
