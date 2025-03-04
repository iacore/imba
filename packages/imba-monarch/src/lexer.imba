# import * as monarch from './monarch'

import {grammar} from './grammar'
import {compile} from './monarch/compile'

import {MonarchTokenizer} from './monarch/lexer'
import {Token} from './monarch/token'
export {Token} from './monarch/token'

extend class Token

	get node
		if scope and scope.start == self
			return scope
		if pops
			return pops
		return self
		
	get nextNode
		next..node
		
	get prevNode
		prev..node

###


###
export class LexedLine
	offset\number
	text\string
	tokens\any[]
	startState\any
	endState\any
	
	def clone newOffset = offset
		let clones = []
		let delta = newOffset - offset
		for tok in tokens
			let clone = tok.clone()
			clone.offset = tok.offset + delta
			clones.push(clone)
		
		return new LexedLine({
			offset: newOffset
			startState: startState
			endState: endState
			text: text
			tokens: clones
		})

# @ts-ignore
const compiled = compile('imba',grammar)
export const lexer = new MonarchTokenizer('imba',compiled)