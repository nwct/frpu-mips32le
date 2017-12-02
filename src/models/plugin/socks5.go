// Copyright 2017 fatedier, fatedier@gmail.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package plugin

import (
	"io"
	"io/ioutil"
	"log"

	frpNet "utils/net"

	gosocks5 "github.com/armon/go-socks5"
)

const PluginSocks5 = "socks5"

func init() {
	Register(PluginSocks5, NewSocks5Plugin)
}

type Socks5Plugin struct {
	Server *gosocks5.Server
}

func NewSocks5Plugin(params map[string]string) (p Plugin, err error) {
	sp := &Socks5Plugin{}
	sp.Server, err = gosocks5.New(&gosocks5.Config{
		Logger: log.New(ioutil.Discard, "", log.LstdFlags),
	})
	p = sp
	return
}

func (sp *Socks5Plugin) Handle(conn io.ReadWriteCloser) {
	defer conn.Close()

	var wrapConn frpNet.Conn
	if realConn, ok := conn.(frpNet.Conn); ok {
		wrapConn = realConn
	} else {
		wrapConn = frpNet.WrapReadWriteCloserToConn(conn)
	}

	sp.Server.ServeConn(wrapConn)
}

func (sp *Socks5Plugin) Name() string {
	return PluginSocks5
}

func (sp *Socks5Plugin) Close() error {
	return nil
}
