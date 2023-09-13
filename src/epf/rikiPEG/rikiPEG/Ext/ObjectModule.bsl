﻿#region vars
var cnst;
var id;
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

procedure intoStructure_cnst(result, keys, start=undefined)
	if start = undefined then
		pos = result.count() + 1;
	else
		pos = start;
	endif;
	
	for each structKey in StrSplit(keys,",") do 
		result.insert(structKey,pos);
		pos = pos + 1;
	enddo;
	
endprocedure

function intoStructure(result = undefined, key0, value0, key1=Undefined, value1 = Undefined, key2=Undefined, value2 = Undefined, key3=Undefined, value3 = Undefined, key4=Undefined, value4 = Undefined, key5=Undefined, value5 = Undefined, key6=Undefined, value6 = Undefined, key7=Undefined, value7 = Undefined, key8=Undefined, value8 = Undefined, key9=Undefined, value9 = Undefined)
	
	if result = undefined then
		result = new Structure;
	endif;
	
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
	
endfunction

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

function sType(typeName)
	return intoStructure(,"type", typeName)
endfunction

function iType(typeName)
	return intoStructure(,"type", cnst[typeName])
endfunction

procedure expectType(obj, typeName)
	if typeof(obj) = type("Structure") 
		and obj.property("type") 
		and obj.type = typeName then
		return;
	endif;
	raise StrTemplate("Expect type %1", typeName);
endprocedure

#region testCheck
function context(string)
	return intoStructure(sType("context"), 
		"buffer", intoStructure(sType("string"), "buffer", string), 
		"position", intoStructure(sType("position"), "position", 1, "line", 1, "column", 1 ));
endfunction

function getPosition(obj)
	expectType(obj,"context");
	expectType(obj.position,"position");
	return obj.position.position;
endfunction

function getBuffer(obj)
	expectType(obj,"context");
	return obj.buffer.buffer;
endfunction

#endregion

function success(context, value, position = undefined)
	#region debug
	if debug() then
		onSuccess(StrTemplate("succes at position = '%1' Value = '%2'", format(getPosition(context),"NG="), value));
	endif;
    #endregion
	return intoStructure(sType("success"), "value", value, "position", ?(position = undefined, context.position, position));
endfunction

function failure(context, message, position = undefined)
	#region debug
	if debug() then
		onFailure(StrTemplate("failure at position = '%1'", format(getPosition(context),"NG=")));
	endif;
    #endregion
	
	return intoStructure(sType("failure"), "message", message, "position", ?(position = undefined, context.position, position));
endfunction


function toString(obj)
	if typeof(obj) = type("Structure") then
		if obj.property("type") then
			if obj.type = "context" then
				return StrTemplate("Context[buffer,%1]", obj.position);
			elsif obj.type = "position" then
				return StrTemplate("pos = %1, line = %2, col = %3", format(obj.position, "NG="), format(obj.line, "NG="), format(obj.column, "NG="));
			else
				raise "unknown type " + obj.type;
			endif;
		else
			raise "Expect property in strucutre"
		endif;
	else
		raise "Expect strucutre"
	endif;
endfunction


/// @src https://helpf.pro/faq8/view/940.html
function HexToDec(val _Hex)
	base = 16;
	_Hex = TrimAll(_Hex);
	maxDeg = StrLen(_Hex) - 1;
	result = 0;
	charCounter = 1;
	while maxDeg >=0 do
		_HexСимвол = Mid(_Hex, charCounter, 1);
		charIndex = Найти("0123456789ABCDEF", _HexСимвол) - 1;
		result = result + charIndex * pow(base, maxDeg);
		maxDeg = maxDeg - 1;
		charCounter = charCounter + 1;
	enddo;   
	return result;
endfunction 

function id()
	id = id + 1;
	return id;
endfunction

function convertChar(char)
	if cnst.convertMap[char] = undefined then
		return char;
	endif;
	return cnst.convertMap[char];
endfunction

function convertString(string)
	result = new Array;
	for i = 1 to StrLen(string) do
		result.Add(convertChar(Mid(string,i,1)));
	enddo;
	return StrConcat(result);
endfunction


function expectMessage(message) export
	
	return intoStructure(iType("expectMessage"), "message", message );
	
endfunction
#region parsers   

function grammar(grammar, name, parser) export
	grammar.insert(name, parser);
	return grammar;
endfunction

function matchiChar(char, expect = Undefined) export
	
	if IsBlankString(expect) then
		message = expectMessage(StrTemplate("Expect char '%1' or '%2'", convertChar(lower(char)), convertChar(upper(char))));
	else
		message = expect;
	endif;
	
	return intoStructure(iType("charClass"), "charClass", intoArray(lower(char), upper(char)), "message", message );
	
endfunction

function matchChar(char, expect = Undefined) export
	
	if expect = Undefined then
		message = expectMessage(StrTemplate("Expect char '%1'", convertChar(char)));
	else
		message = expect;
	endif;
	
	return intoStructure(iType("charClass"), "charClass", intoArray(char), "message", message );
	
endfunction

function matchRange(charFrom, charTo, expect="") export
	
	if IsBlankString(expect) then
		message = expectMessage(StrTemplate("Expect char from range [%1-%2]", convertChar(charFrom), convertChar(charTo)));
	else
		message = expect;
	endif;
	
	charClass = new Array;
	for charCode = CharCode(charFrom) to CharCode(charTo) do 
		charClass.Add(Char(charCode));
	enddo;
	
	return intoStructure(iType("charClass"), "charClass", charClass, "message", message);
	
endfunction

function matchSimpleString(string, expect="") export
	
	if IsBlankString(expect) then
		message = expectMessage(StrTemplate("Expect string '%1'", convertString(string)));
	else
		message = expect;
	endif;
	
	return intoStructure(iType("string"), "string", string, "strLen", StrLen(string), "message", message);
	
endfunction

function matchiSimpleString(string, expect="") export
	
	if IsBlankString(expect) then
		message = expectMessage(StrTemplate("Expect case-insensitive string '%1'", ConvertString(string)));          
	else
		message = expect;
	endif;
	
	return intoStructure(iType("istring"), "string", lower(string), "strLen", StrLen(string), "message", message);
	
endfunction

function matchSeq(arg0, arg1= Undefined, arg2 = Undefined, arg3= Undefined, arg4= Undefined, arg5= Undefined, arg6= Undefined, arg7= Undefined, arg8= Undefined, arg9= Undefined, 
	arg10= Undefined, arg11= Undefined, arg12 = Undefined, arg13= Undefined, arg14= Undefined, arg15= Undefined, arg16= Undefined, arg17= Undefined, arg18= Undefined, arg19= Undefined, 
	arg20= Undefined, arg21= Undefined, arg22 = Undefined, arg23= Undefined, arg24= Undefined, arg25= Undefined, arg26= Undefined, arg27= Undefined, arg28= Undefined, arg29= Undefined) export
	
	seqArray = intoArray(arg0, arg1, arg2 , arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 , arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22 , arg23, arg24, arg25, arg26, arg27, arg28, arg29);
	message = undefined;
	for i = -seqArray.UBound() to 0 do
		
		if seqArray[-i].type = cnst.expectMessage then 
			message = seqArray[-i];
			seqArray.delete(-i);
		endif;
		
	enddo;
	
	return intoStructure(iType("seq"), "message", message, "parsers", intoArray(arg0, arg1, arg2 , arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 , arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22 , arg23, arg24, arg25, arg26, arg27, arg28, arg29));
	
endfunction


#endregion

function updatePosition(context,char)
	#region debug
	if debug() then
		onEnter("updatePosition", StrTemplate("char = '%1'", convertChar(char)));
	endif;
    #endregion
	
	
	context.position.position = context.position.position + 1;
	if char = chars.CR then
		context.position.line = context.position.line + 1;
		context.position.column = 1;
	else		
		context.position.column = context.position.column + 1;
	endif;
	#region debug
	if debug() then
		onExit("updatePosition", StrTemplate("new position = %1", toString(context.position)));
	endif;
	#endregion
	return context;
	
endfunction

function getChar(context)

	#region debug
	if debug() then
		onEnter("getChar", StrTemplate("position = '%1'", toString(context)));
	endif;
    #endregion
	
	value = Mid(getBuffer(context), getPosition(context), 1);

	#region debug
	if debug() then
		onExit("getChar", StrTemplate("read char  = '%1'", value));
	endif;
	#endregion
	
	return value;
endfunction


#region parsers   
function onParseString(context, grammar, parser)
	#region debug
	if debug() then
		onEnter("onParseString", StrTemplate("%1", parser.message));
	endif;
    #endregion
	
	savedPosition =  intoStructure(sType("position"), "position", context.position.position, "line", context.position.line, "column", context.position.column);
	stringArray = new Array;
	for i = 1 to parser.strLen do
		char = getChar(context);
		updatePosition(context,char);
		stringArray.Add(char);
	enddo;
	
	readedString = StrConcat(stringArray);
	if parser.string = readedString then
		result =  success(context, readedString);
	else
		context.position = savedPosition;
		result =  failure(context, parser.message);
	endif;
	
	#region debug
	if debug() then
		onExit("onParse", new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParseiString(context, grammar, parser)
	#region debug
	if debug() then
		onEnter("onParseiString", StrTemplate("%1", parser.message));
	endif;
    #endregion
	
	savedPosition =  intoStructure(sType("position"), "position", context.position.position, "line", context.position.line, "column", context.position.column);
	stringArray = new Array;
	for i = 1 to parser.strLen do
		char = getChar(context);
		updatePosition(context,char);
		stringArray.Add(char);
	enddo;
	
	readedString = StrConcat(stringArray);
	if parser.string = Lower(readedString) then
		result =  success(context, readedString);
	else
		context.position = savedPosition;
		result =  failure(context, parser.message);
	endif;
	
	#region debug
	if debug() then
		onExit("onParse", new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParseChar(context, grammar, parser)
	#region debug
	if debug() then
		onEnter("onParseChar", StrTemplate("%1", parser.message));
	endif;
    #endregion
	
	char = getChar(context);
	if parser.charClass.find(char) = Undefined then
		result =  failure(context, parser.message);
	else
		result =  success(updatePosition(context,char), char);
	endif;
	
	#region debug
	if debug() then
		onExit("onParse", new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParseSeq(context, grammar, parser)
	#region debug
	if debug() then
		onEnter("onParseSeq", StrTemplate("%1", parser.message));
	endif;
    #endregion
	
	savedPosition =  intoStructure(sType("position"), "position", context.position.position, "line", context.position.line, "column", context.position.column);
	
	for each seqparser in parser.Parsers do 
		
	enddo;

	if parser.string = 1 then
		result =  success(context, 1);
	else
		context.position = savedPosition;
		result =  failure(context, parser.message);
	endif;
	
	#region debug
	if debug() then
		onExit("onParse", new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction


function onParseAlt(context, grammar, parser)
	functionName = "onParseAlt";
	#region debug
	if debug() then
		onEnter(functionName, StrTemplate("%1", parser.message));
	endif;
    #endregion
	
    result = Undefined;
	raise "TODO "+functionName;
	
	#region debug
	if debug() then
		onExit(functionName, new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParseNot(context, grammar, parser)
	functionName = "onParseNot";
	#region debug
	if debug() then
		onEnter(functionName, StrTemplate("%1", parser.message));
	endif;
    #endregion
	
	result = Undefined;
    raise "TODO "+functionName;
	
	
	#region debug
	if debug() then
		onExit(functionName, new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParsePlus(context, grammar, parser)
	functionName = "onParsePlus";
	#region debug
	if debug() then
		onEnter(functionName, StrTemplate("%1", parser.message));
	endif;
    #endregion
	
    result = Undefined;
	raise "TODO "+functionName;
	
	#region debug
	if debug() then
		onExit(functionName, new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParseStar(context, grammar, parser)
	functionName = "onParseStar";
	#region debug
	if debug() then
		onEnter(functionName, StrTemplate("%1", parser.message));
	endif;
    #endregion
	
    result = Undefined;
    raise "TODO "+functionName;
	
	#region debug
	if debug() then
		onExit(functionName, new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParseQuest(context, grammar, parser)
	functionName = "onParseQuest";
	#region debug
	if debug() then
		onEnter(functionName, StrTemplate("%1", parser.message));
	endif;
    #endregion
	
    result = Undefined;
    raise "TODO "+functionName;
	
	#region debug
	if debug() then
		onExit(functionName, new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParseAny(context, grammar, parser)
	functionName = "onParseAny";
	#region debug
	if debug() then
		onEnter(functionName, StrTemplate("%1", parser.message));
	endif;
    #endregion
	
    result = Undefined;
    raise "TODO "+functionName;
	
	#region debug
	if debug() then
		onExit(functionName, new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParseEOF(context, grammar, parser)
	functionName = "onParseEOF";
	#region debug
	if debug() then
		onEnter(functionName, StrTemplate("%1", parser.message));
	endif;
    #endregion
	
    result = Undefined;
    raise "TODO "+functionName;
	
	#region debug
	if debug() then
		onExit(functionName, new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParseBind(context, grammar, parser)
	functionName = "onParseBind";
	#region debug
	if debug() then
		onEnter(functionName, StrTemplate("%1", parser.message));
	endif;
    #endregion
	
    result = Undefined;
    raise "TODO "+functionName;
	
	#region debug
	if debug() then
		onExit(functionName, new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParseLookAhead(context, grammar, parser)
	functionName = "onParseLookAhead";
	#region debug
	if debug() then
		onEnter(functionName, StrTemplate("%1", parser.message));
	endif;
    #endregion
	
    result = Undefined;
    raise "TODO "+functionName;
	
	#region debug
	if debug() then
		onExit(functionName, new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParseFN(context, grammar, parser)
	functionName = "onParseFN";
	#region debug
	if debug() then
		onEnter(functionName, StrTemplate("%1", parser.message));
	endif;
    #endregion
	
    result = Undefined;
    raise "TODO "+functionName;
	
	#region debug
	if debug() then
		onExit(functionName, new Structure("result", result));
	endif;
	#endregion
	return result;
endfunction

function onParse(context, grammar, parser) 
	#region debug
	if debug() then
		onEnter("onParse", StrTemplate("parser = '%1'", parser));
	endif;
    #endregion

	curParser = grammar[parser];
	if not curParser.property("type") then
		raise "incorrect parser type";
	endif;
	
	if curParser.type = cnst.charClass then
		result = onParseChar(context, grammar, curParser);
	elsif curParser.type = cnst.string then
		result = onParseString(context, grammar, curParser);
	elsif curParser.type = cnst.istring then
		result = onParseiString(context, grammar, curParser);
	elsif curParser.type = cnst.seq then
		result = onParseSeq(context, grammar, curParser);
	elsif curParser.type = cnst.alt then
		result = onParseAlt(context, grammar, curParser);
	elsif curParser.type = cnst.not then
		result = onParseNot(context, grammar, curParser);
	elsif curParser.type = cnst.any then
		result = onParseAny(context, grammar, curParser);
	elsif curParser.type = cnst.eof then
		result = onParseEof(context, grammar, curParser);
	elsif curParser.type = cnst.lookahead then
		result = onParseLookAhead(context, grammar, curParser);
	elsif curParser.type = cnst.plus then
		result = onParsePlus(context, grammar, curParser);
	elsif curParser.type = cnst.star then
		result = onParseStar(context, grammar, curParser);
	elsif curParser.type = cnst.quest then
		result = onParseQuest(context, grammar, curParser);
	elsif curParser.type = cnst.bind then
		result = onParseBind(context, grammar, curParser);
	elsif curParser.type = cnst.fn then
		result = onParseFN(context, grammar, curParser);
	else 
		raise StrTemplate("Unknown type '%1'", curParser.typeName[curParser.type]);
	endif;

	#region debug
	if debug() then
		onExit("onParse", new Structure("result", result));
	endif;
	#endregion

	return result;
endfunction

#endregion


function parse(buffer, grammar, start = "start" ) export
	
	#region debug
	if debug() then
		onEnter("parse", new Structure("buffer, grammar, start", buffer, grammar, start));
	endif;
    #endregion
	
	context = context(buffer);
	
	result = onParse(context, grammar, start);
	
	#region debug
	if debug() then
		onExit("parse", new Structure("result", result));
	endif;
	#endregion
	
	return result;

endfunction

function initSettings()
	initSettings = new Structure;
	intoStructure(initSettings, "debugObject", undefined);
	
	return initSettings;
	
EndFunction

#region debug
function debug()
	return cnst.settings.debug;
endfunction

procedure onEnter(name, args)

	cnst.settings.debugObject.onEnter(name,args);
	
endprocedure

procedure onFailure(args)

	cnst.settings.debugObject.onFailure(args);
	
endprocedure

procedure onSuccess(args)

	cnst.settings.debugObject.onSuccess(args);
	
endprocedure

procedure onExit(name, args)

	cnst.settings.debugObject.onExit(name,args);
	
endprocedure

#endregion

procedure init(initSettings=undefined) export
	
	if initSettings = undefined then
		settings = initSettings();
	elsif typeOf(initSettings) = type("Structure") then
		settings = initSettings();
		for each x in settings do
			if initSettings.property(x.key) then
				settings[x.key] = initSettings[x.key];
			endif;
		enddo;
	else
		raise "initSettings must be structure";
	endif;
	
	settings.insert("debug", not settings.debugObject = undefined);
	
	id = 0;
	_grammar = new Structure;
	cnst = new Structure;
	intoStructure_cnst(cnst,"inf",-1);
	intoStructure_cnst(cnst,"expectMessage");
	intoStructure_cnst(cnst,"charClass");
	intoStructure_cnst(cnst,"string");
	intoStructure_cnst(cnst,"istring");
	intoStructure_cnst(cnst,"seq");
	
	cnst.Insert("settings", settings);
	parserStorage = new Structure;
	
	
	convertMap = new Map;
	convertMap[Chars.CR] = "\n";
	convertMap[Chars.Tab] = "\t";
	convertMap[Chars.LF] = "\r";
	convertMap[Chars.FF] = "\FF\";
	convertMap[Chars.NBSp] = "\NBSp\";
	convertMap[Chars.VTab] = "\VTab\";
	
	intoStructure(cnst, "convertMap", convertMap);
	
	
	
endprocedure


