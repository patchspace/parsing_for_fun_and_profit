global._ = require('underscore')

chai = require('chai')
global.expect = chai.expect

global.PEG = require('pegjs')
fs = require('fs')

listGrammar = fs.readFileSync('./lib/list_parser/list.pegjs', encoding: 'utf8')
global.newListParser = -> PEG.buildParser(listGrammar, { cache: true, trackLineAndColumn: true })

