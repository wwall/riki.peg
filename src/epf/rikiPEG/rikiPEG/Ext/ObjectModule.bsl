var parserStorage;
var cnst;
var id;
var stream;
var stack;
var dataReader;




function id()
	id = id + 1;
	return id;
endfunction

#region stack

procedure push(value)
	stack.add(value);
endprocedure

function top()
	return stack[stack.UBound()];
endfunction

function pop()
	value = stack[stack.UBound()];
	stack.delete(stack.UBound());
	return value;
endfunction
	
#endregion


#region collection

procedure addValue(collection, key, value)
	if key = Undefined then
		return;
	endif;
	collection.insert(key, value);
EndProcedure

procedure addArray(resultArray, arg)
	
	if arg = Undefined then
		Return;
	endif;
	resultArray.Add(arg);
	
EndProcedure

function intoMap(key0, value0, key1=Undefined, value1 = Undefined, key2=Undefined, value2 = Undefined, key3=Undefined, value3 = Undefined, key4=Undefined, value4 = Undefined, key5=Undefined, value5 = Undefined, key6=Undefined, value6 = Undefined, key7=Undefined, value7 = Undefined, key8=Undefined, value8 = Undefined, key9=Undefined, value9 = Undefined)
	result = new Map;
	addValue(result, key0, value0);
	addValue(result, key1, value1);
	addValue(result, key2, value2);
	addValue(result, key3, value3);
	addValue(result, key4, value4);
	addValue(result, key5, value5);
	addValue(result, key6, value6);
	addValue(result, key7, value7);
	addValue(result, key8, value8);
	addValue(result, key9, value9);
	
	Return result;
EndFunction

function intoStructure(key0, value0, key1=Undefined, value1 = Undefined, key2=Undefined, value2 = Undefined, key3=Undefined, value3 = Undefined, key4=Undefined, value4 = Undefined, key5=Undefined, value5 = Undefined, key6=Undefined, value6 = Undefined, key7=Undefined, value7 = Undefined, key8=Undefined, value8 = Undefined, key9=Undefined, value9 = Undefined)
	result = new Structure;
	addValue(result, key0, value0);
	addValue(result, key1, value1);
	addValue(result, key2, value2);
	addValue(result, key3, value3);
	addValue(result, key4, value4);
	addValue(result, key5, value5);
	addValue(result, key6, value6);
	addValue(result, key7, value7);
	addValue(result, key8, value8);
	addValue(result, key9, value9);
	
	Return result;
EndFunction

function intoArray(
	arg0, arg1= Undefined, arg2 = Undefined, arg3= Undefined, arg4= Undefined, arg5= Undefined, arg6= Undefined, arg7= Undefined, arg8= Undefined, arg9= Undefined, 
	arg10= Undefined, arg11= Undefined, arg12 = Undefined, arg13= Undefined, arg14= Undefined, arg15= Undefined, arg16= Undefined, arg17= Undefined, arg18= Undefined, arg19= Undefined, 
	arg20= Undefined, arg21= Undefined, arg22 = Undefined, arg23= Undefined, arg24= Undefined, arg25= Undefined, arg26= Undefined, arg27= Undefined, arg28= Undefined, arg29= Undefined  )
	resultArray = new Array;
	addArray(resultArray, arg0);
	addArray(resultArray, arg1);
	addArray(resultArray, arg2);
	addArray(resultArray, arg3);
	addArray(resultArray, arg4);
	addArray(resultArray, arg5);
	addArray(resultArray, arg6);
	addArray(resultArray, arg7);
	addArray(resultArray, arg8);
	addArray(resultArray, arg9);
	
	addArray(resultArray, arg10);
	addArray(resultArray, arg11);
	addArray(resultArray, arg12);
	addArray(resultArray, arg13);
	addArray(resultArray, arg14);
	addArray(resultArray, arg15);
	addArray(resultArray, arg16);
	addArray(resultArray, arg17);
	addArray(resultArray, arg18);
	addArray(resultArray, arg19);
	
	addArray(resultArray, arg20);
	addArray(resultArray, arg21);
	addArray(resultArray, arg22);
	addArray(resultArray, arg23);
	addArray(resultArray, arg24);
	addArray(resultArray, arg25);
	addArray(resultArray, arg26);
	addArray(resultArray, arg27);
	addArray(resultArray, arg28);
	addArray(resultArray, arg29);
	
	Return resultArray
endfunction

#endregion

#region testCheck

function testCheck() export
	return 1;
endfunction

#endregion

#region declare

function matchiChar(char) export
	
	set = new Array;
	set.Add(upper(char));
	set.Add(lower(char));
	return new Structure("type, set", cnst.range, set);
	
endfunction

function matchChar(char) export
	set = new Array;
	set.Add(char);
	return new Structure("type, set", cnst.range, set);
endfunction

function matchString(string) export
	
	array = new array;
	for each x in StrSplit(string,"") do
		array.add(matchChar(x));
	enddo;
	
	return seq2(array);
endfunction

function matchiString(string) export
	
	array = new array;
	for each x in StrSplit(string,"") do
		array.add(matchiChar(x));
	enddo;
	
	return seq2(array);
endfunction

function matchRange(fromChar, toChar) export
	set = new Array;
	for value = CharCode(fromChar) to CharCode(toChar) do
		set.Add(Char(value));
	enddo;
	return new Structure("type,  set", cnst.range, set);
endfunction

function seq(arg0, arg1= Undefined, arg2 = Undefined, arg3= Undefined, arg4= Undefined, arg5= Undefined, arg6= Undefined, arg7= Undefined, arg8= Undefined, arg9= Undefined, arg10= Undefined, arg11= Undefined, arg12 = Undefined, arg13= Undefined, arg14= Undefined, arg15= Undefined, arg16= Undefined, arg17= Undefined, arg18= Undefined, arg19= Undefined, arg20= Undefined, arg21= Undefined, arg22 = Undefined, arg23= Undefined, arg24= Undefined, arg25= Undefined, arg26= Undefined, arg27= Undefined, arg28= Undefined, arg29= Undefined  ) export
	
	seqArray = intoArray(arg0, arg1, arg2 , arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 , arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22 , arg23, arg24, arg25, arg26, arg27, arg28, arg29 ); 
	return new Structure("type, args", cnst.seq, seqArray);
	
endfunction

function seq2(seqArray) export
	
	return new Structure("type, args", cnst.seq, seqArray);
	
endfunction

function alt2(seqArray) export
	
	return new Structure("type, args", cnst.alt, seqArray);
	
endfunction

function neg(parser) export
	
	return new Structure("type, args", cnst.not, parser);
	
endfunction

function positive(parser) export
	
	return new Structure("type, args", cnst.positive, parser);
	
endfunction


function alt(arg0, arg1= Undefined, arg2 = Undefined, arg3= Undefined, arg4= Undefined, arg5= Undefined, arg6= Undefined, arg7= Undefined, arg8= Undefined, arg9= Undefined, arg10= Undefined, arg11= Undefined, arg12 = Undefined, arg13= Undefined, arg14= Undefined, arg15= Undefined, arg16= Undefined, arg17= Undefined, arg18= Undefined, arg19= Undefined, arg20= Undefined, arg21= Undefined, arg22 = Undefined, arg23= Undefined, arg24= Undefined, arg25= Undefined, arg26= Undefined, arg27= Undefined, arg28= Undefined, arg29= Undefined  ) export
	
	seqArray = intoArray(arg0, arg1, arg2 , arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 , arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22 , arg23, arg24, arg25, arg26, arg27, arg28, arg29 ); 
	return new Structure("type, args", cnst.alt, seqArray);
	
endfunction

function repeat(parser,min,max) export
	
	return new Structure("type, min, max", cnst.repeat, min, max);
	
endfunction

function plus(parser) export
	
	return repeat(parser,1,cnst.inf);
	
endfunction

function star(parser) export
	
	return repeat(parser,0,cnst.inf);
	
endfunction

function quest(parser) export
	
	return repeat(parser,0,1);
	
endfunction

function fn(parser, code) export
	
	return new Structure("type, parser, code", cnst.fn, parser, code);
	
endfunction


function addParser(name,parser) export
	parserStorage.insert(name,parser);
endfunction

#endregion

#region stream

function initStream_string(string)
	stream = undefined;
	dataReader = undefined;
	stream = new MemoryStream;
	writer = new DataWriter(stream);
	writer.WriteLine(string);
	stream.seek(0,PositionInStream.Begin);
	return new Structure("pos, line, column", 0, 1, 1);
	
endfunction


#endregion

function readChar(state)
	
	if dataReader = undefined then
		dataReader = new DataReader(stream);
	endif;
	
	return dataReader.ReadChars(1);
	
endfunction

function updateLineColumn_inc(state, char)
	state.pos = state.pos + 1;
	
	if char = chars.CR then
		state.line = state.line + 1;
		state.column = 1;
	else
		state.column = state.column + 1;
	endif;
	
endfunction

function succes(state, result)
	
	return new Structure("succes, state, result", true, state, result);
	
endfunction

function failure()
	localstate = pop();
	offset =  localstate.pos - stream.CurrentPosition();
	if offset <> 0 then
		stream.seek(offset,PositionInStream.Current);
	endif;
	dataReader = undefined;
	return new Structure("succes, state", false, localstate);
	
endfunction


function apply_range(parser, state)
	push(state);
	char = readChar(state);
	if parser.set.Find(char) = Undefined then
		return failure();
	endif;
	pop();
	updateLineColumn_inc(state, char);
	return succes(state, char);
	
endfunction



function apply_alt(parser, state)
	
	for each parser in parser.args do
		push(state);
		result = applyParser(parser,state);
		if result.succes then
			pop();
			return result;
		endif;
	enddo;
	
	return failure();	
	
endfunction



function applyParser(parser, state)
	if typeOf(parser) = Type("string") then
		localParser = parserStorage[parser];
	else 
		localParser = parser;
	endif;
	
	if localParser.type = cnst.range then
		result = apply_range(localParser, state)
	elsif localParser.type = cnst.alt then
		result = apply_alt(localParser, state)
	else
		raise "Unknown type";
	endif;
	
	return result;
	
endfunction


function apply(string, name) export
	state = initStream_string(string);
	stack = new Array;
	return applyParser(name, state);
endfunction



procedure init()
	id = 0;
	cnst = intoStructure("inf",-1,
	"range", id(), 
	"alt", id(), 
	"seq", id(), 
	"repeat", id(), 
	"fn", id(), 
	"positive", id(), 
	"not", id());
	
	parserStorage = new Structure;
	
endprocedure

init();

