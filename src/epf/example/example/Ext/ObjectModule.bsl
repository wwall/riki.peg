#region tests

Перем КонтекстЯдра;
Перем Ожидаем;

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов, КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	НаборТестов.НачатьГруппу("Проверка парсера");
	НаборТестов.Добавить("Ситуация1");
	НаборТестов.Добавить("Ситуация2");
	НаборТестов.Добавить("Ситуация3");
	
	
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
КонецПроцедуры


Процедура Ситуация1() Экспорт
	
	result = parseTextFromString_1("{1, 2}");
	Ожидаем.Что(result.result[0].type).Равно("number");
	Ожидаем.Что(result.result[0].value).Равно(1);
	Ожидаем.Что(result.result[1].type).Равно("number");
	Ожидаем.Что(result.result[1].value).Равно(2);
	
КонецПроцедуры


Процедура Ситуация2() Экспорт
	
	result = parseTextFromString_2("{1, {3,4}, 2}");
	Ожидаем.Что(result.result[0].type).Равно("number");
	Ожидаем.Что(result.result[0].value).Равно(1);
	Ожидаем.Что(result.result[1][0].type).Равно("number");
	Ожидаем.Что(result.result[1][0].value).Равно(3);
	Ожидаем.Что(result.result[1][1].type).Равно("number");
	Ожидаем.Что(result.result[1][1].value).Равно(4);
	Ожидаем.Что(result.result[2].type).Равно("number");
	Ожидаем.Что(result.result[2].value).Равно(2);
	
КонецПроцедуры


Процедура Ситуация3() Экспорт
	
	result = parseTextFromString_1("{1.1, .2, 3.,  4}");
	Ожидаем.Что(result.result[0].type).Равно("number");
	Ожидаем.Что(result.result[0].value).Равно(1.1);
	Ожидаем.Что(result.result[1].type).Равно("number");
	Ожидаем.Что(result.result[1].value).Равно(0.2);
	Ожидаем.Что(result.result[2].type).Равно("number");
	Ожидаем.Что(result.result[2].value).Равно(3);
	Ожидаем.Что(result.result[3].type).Равно("number");
	Ожидаем.Что(result.result[3].value).Равно(4);
	
КонецПроцедуры


#endregion


function CreatePEG()

	current = new File(ThisObject.UsedFileName);
	result = current.Path + "\rikiPEG.epf";
	return ExternalDataProcessors.Create(result, false);
	
endfunction


#region grammars

#region case1

function parseTextFromString_1(inputString) export
	
	peg = CreatePEG();
	value.Rows.Clear();
	value.Columns.Clear();
	grammar_1(peg);
	return peg.apply(inputString, "list");
	
EndFunction

/// Грамматика разбирает только строки вида { number, number ... , number}
procedure grammar_1(peg)
	// grammar for file
	// list = open a:elements close {result = a;}
	// elements = a:Element b:rest { result = new array; result.add(a); for each x in b do result.add(x); enddo;}
	// rest = (comma a:elements)?   {result = a;}
	//Element = Number 
	//Number = a:[0-9]+   {result = number(strConcat(a))}
	//open = ws \{ ws
	//close = ws \} ws
	//comma = ws \, ws
	//ws = (#Space / #Tab / #CR / #LF)*
	
	
	peg.addParser("list",
		peg.fn(
			peg.seq(
				peg.ref("OPEN"),
				peg.bind("a",peg.ref("elements")),
				peg.ref("CLOSE")),
			"result = a;"));
			
	peg.addParser("elements",
		peg.fn(
			peg.seq(
				peg.bind("a", peg.ref("element")),
				peg.bind("b", peg.ref("rest"))),
		"result = new array; 
		|result.add(a); 
		|for each x in b do 
		|result.add(x); 
		|enddo;"));
	peg.addParser("rest",
		peg.quest(
			peg.fn(
				peg.seq(
					peg.ref("comma"),
					peg.bind("a",peg.ref("elements"))),
				"result = a;"), 
			new Array));
				
	peg.addParser("element", peg.ref("number"));
	
	peg.addParser("number", 
		peg.fn(
			peg.bind("a",peg.ref("DIGITS")),
			"result = new Structure(""type,value"",""number"",number(a));"));
	peg.addParser("DIGITS",
		peg.fn(
			peg.plus(peg.ref("DIGIT")),
			"result = strConcat(result)"));
	peg.addParser("DIGIT",peg.matchRange("0","9"));
	peg.addParser("OPEN",peg.seq(peg.ref("ws"),peg.matchChar("{"),peg.ref("ws")));
	peg.addParser("CLOSE",peg.seq(peg.ref("ws"),peg.matchChar("}"),peg.ref("ws")));
	peg.addParser("COMMA",peg.seq(peg.ref("ws"),peg.matchChar(","),peg.ref("ws")));
	peg.addParser("ws",peg.star(peg.alt(peg.matchChar(" "), peg.matchChar(Chars.Tab), peg.matchChar(Chars.CR), peg.matchChar(Chars.LF))));
	
endprocedure

#endregion

#region case2

function parseTextFromString_2(inputString) export
	
	peg = CreatePEG();
	value.Rows.Clear();
	value.Columns.Clear();
	grammar_2(peg);
	return peg.apply(inputString, "list");
	
EndFunction

/// Грамматика разбирает строки из первого случая и дополнительно ыложенный списки
/// { number, number, {number, number}, number ... , number}
procedure grammar_2(peg)
	// grammar for file
	// list = \{ a:elements \} {result = a;}
	// elements = a:Element b:rest { result = new array; result.add(a); for each x in b do result.add(x); enddo;}
	// rest = (\, a:elements)?   {result = a;}
	//Element = Number / list
	//Number = a:[0-9]+   {result = number(strConcat(a))}
	
	peg.addParser("list",
		peg.fn(
			peg.seq(
				peg.ref("OPEN"),
				peg.bind("a",peg.ref("elements")),
				peg.ref("CLOSE")),
			"result = a;"));
			
	peg.addParser("elements",
		peg.fn(
			peg.seq(
				peg.bind("a", peg.ref("element")),
				peg.bind("b", peg.ref("rest"))),
		"result = new array; 
		|result.add(a); 
		|for each x in b do 
		|result.add(x); 
		|enddo;"));
	peg.addParser("rest",
		peg.quest(
			peg.fn(
				peg.seq(
					peg.ref("comma"),
					peg.bind("a",peg.ref("elements"))),
				"result = a;"), 
			new Array));
				
	peg.addParser("element", peg.alt(
		peg.ref("number"),
		peg.ref("list")));
	
	peg.addParser("number", 
		peg.fn(
			peg.bind("a",peg.ref("DIGITS")),
			"result = new Structure(""type,value"",""number"",number(a));"));
	peg.addParser("DIGITS",
		peg.fn(
			peg.plus(peg.ref("DIGIT")),
			"result = strConcat(result)"));
	peg.addParser("DIGIT",peg.matchRange("0","9"));
	peg.addParser("OPEN",peg.seq(peg.ref("ws"),peg.matchChar("{"),peg.ref("ws")));
	peg.addParser("CLOSE",peg.seq(peg.ref("ws"),peg.matchChar("}"),peg.ref("ws")));
	peg.addParser("COMMA",peg.seq(peg.ref("ws"),peg.matchChar(","),peg.ref("ws")));
	peg.addParser("ws",peg.star(peg.alt(peg.matchChar(" "), peg.matchChar(Chars.Tab), peg.matchChar(Chars.CR), peg.matchChar(Chars.LF))));
	
endprocedure

#endregion

#region case3

function parseTextFromString_3(inputString) export
	
	peg = CreatePEG();
	value.Rows.Clear();
	value.Columns.Clear();
	grammar_3(peg);
	return peg.apply(inputString, "list");
	
EndFunction

/// Грамматика разбирает строки из второго случая и дополнительно пониамет десятичную запись числа
procedure grammar_3(peg)
	// grammar for file
	// list = \{ a:elements \} {result = a;}
	// elements = a:Element b:rest { result = new array; result.add(a); for each x in b do result.add(x); enddo;}
	// rest = (\, a:elements)?   {result = a;}
	//Element = Number / list
	//Number = digits \. digits
	//		| 	digits \.
	//		| 	 \. digits
	//		| digits
	
	//digits = a:([0-9]+)   {result = number(strConcat(a))}
	
	peg.addParser("list",
		peg.fn(
			peg.seq(
				peg.ref("OPEN"),
				peg.bind("a",peg.ref("elements")),
				peg.ref("CLOSE")),
			"result = a;"));
			
	peg.addParser("elements",
		peg.fn(
			peg.seq(
				peg.bind("a", peg.ref("element")),
				peg.bind("b", peg.ref("rest"))),
		"result = new array; 
		|result.add(a); 
		|for each x in b do 
		|result.add(x); 
		|enddo;"));
	peg.addParser("rest",
		peg.quest(
			peg.fn(
				peg.seq(
					peg.ref("comma"),
					peg.bind("a",peg.ref("elements"))),
				"result = a;"), 
			new Array));
				
	peg.addParser("element", peg.alt(
		peg.ref("number"),
		peg.ref("list")));
		
	peg.addParser("number", peg.alt(
		peg.ref("number01"), 
		peg.ref("number02"), 
		peg.ref("number03"), 
		peg.ref("number04")));
		
	peg.addParser("number01", peg.fn(
		peg.seq(
			peg.bind("a",peg.ref("DIGITS")),
			peg.ref("dot"),
			peg.bind("b",peg.ref("DIGITS"))),
			"result = new Structure(""type,value"",""number"",number(a+"".""+b));"));
	peg.addParser("number02", peg.seq(
		peg.fn(
			peg.bind("a",peg.ref("DIGITS")),"result = new Structure(""type,value"",""number"",number(a));"),
			peg.ref("dot")));
	peg.addParser("number03", peg.seq(
		peg.ref("dot"),
		peg.fn(
			peg.bind("a",peg.ref("DIGITS")),
			"result = new Structure(""type,value"",""number"",number(a/10));")));
	peg.addParser("number04", 
		peg.fn(
			peg.bind("a",peg.ref("DIGITS")),
			"result = new Structure(""type,value"",""number"",number(a));"));
			
	peg.addParser("DIGITS",
		peg.fn(
			peg.plus(peg.ref("DIGIT")),
			"result = strConcat(result)"));
	peg.addParser("DIGIT",peg.matchRange("0","9"));
	peg.addParser("OPEN",peg.seq(peg.ref("ws"),peg.matchChar("{"),peg.ref("ws")));
	peg.addParser("CLOSE",peg.seq(peg.ref("ws"),peg.matchChar("}"),peg.ref("ws")));
	peg.addParser("COMMA",peg.seq(peg.ref("ws"),peg.matchChar(","),peg.ref("ws")));
	peg.addParser("dot",peg.matchChar(","));
	peg.addParser("ws",peg.start(peg.alt(peg.matchChar(" "), peg.matchChar(Chars.Tab), peg.matchChar(Chars.CR), peg.matchChar(Chars.LF))));
	
endprocedure

#endregion


#endregion