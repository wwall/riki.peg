#region tests
Перем КонтекстЯдра;
Перем Ожидаем;
Перем riki;

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов, КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	НаборТестов.НачатьГруппу("Проверка");
	НаборТестов.Добавить("ТестДолжен_ВыполнитьПроверку");
	НаборТестов.НачатьГруппу("char");
	НаборТестов.Добавить("check_pos_char");
	НаборТестов.Добавить("check_neg_char");
	НаборТестов.Добавить("check_pos_ichar");
	НаборТестов.Добавить("check_neg_ichar");
	НаборТестов.НачатьГруппу("range");
	НаборТестов.Добавить("check_pos_range");
	НаборТестов.Добавить("check_neg_range");
	НаборТестов.НачатьГруппу("string");
	НаборТестов.Добавить("check_pos_string");
	НаборТестов.Добавить("check_neg_string");
	НаборТестов.Добавить("check_pos_istring");
	НаборТестов.Добавить("check_neg_istring");
	НаборТестов.НачатьГруппу("seq");
	НаборТестов.Добавить("check_pos_seq");
	НаборТестов.Добавить("check_neg_seq");
	НаборТестов.НачатьГруппу("alt");
	НаборТестов.Добавить("check_pos_alt");
	НаборТестов.Добавить("check_neg_alt");
	НаборТестов.НачатьГруппу("not");
	НаборТестов.Добавить("check_pos_not");
	НаборТестов.Добавить("check_neg_not");
	НаборТестов.НачатьГруппу("any");
	НаборТестов.Добавить("check_pos_any");
	НаборТестов.Добавить("check_neg_any");
	НаборТестов.НачатьГруппу("eof");
	НаборТестов.Добавить("check_pos_eof");
	НаборТестов.Добавить("check_neg_eof");
	НаборТестов.НачатьГруппу("quest");
	НаборТестов.Добавить("check_pos_quest");
	НаборТестов.Добавить("check_neg_quest");
	НаборТестов.НачатьГруппу("star");
	НаборТестов.Добавить("check_pos_star");
	НаборТестов.Добавить("check_neg_star");
	НаборТестов.НачатьГруппу("plus");
	НаборТестов.Добавить("check_pos_plus");
	НаборТестов.Добавить("check_neg_plus");
	НаборТестов.НачатьГруппу("lookahead");
	НаборТестов.Добавить("check_pos_lookahead");
	НаборТестов.Добавить("check_neg_lookahead");
	НаборТестов.НачатьГруппу("fn");
	НаборТестов.Добавить("check_pos_fn");
	НаборТестов.Добавить("check_neg_fn");

КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	
	ФайлТеста = Новый Файл(ЭтотОбъект.ИспользуемоеИмяФайла);
	ФайлОбработки = ФайлТеста.Путь + "..\epf\rikiPEG.epf";
	
	riki = ВнешниеОбработки.Создать(ФайлОбработки, Ложь);
	riki.init();
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
КонецПроцедуры

#EndRegion

Процедура ТестДолжен_ВыполнитьПроверку() Экспорт
	
	Ожидаем.Что(riki.testCheck(),"Обработка корректно подключилась").Равно(1);
	
КонецПроцедуры

#region test_char

Процедура check_pos_char() Экспорт
	grammar = new Structure;
	parser = riki.matchChar("z");
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("z", grammar );
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("z");
	Ожидаем.Что(result.position.position).Равно(2);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_char() Экспорт
	
	grammar = new Structure;
	parser = riki.matchChar("z");
	grammar = riki.Grammar(grammar,"start",parser);
	result = riki.parse("a", grammar );
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("Ожидается символ [z]");
	else
		Ожидаем.Что(result.message.message).Равно("Expect char [z]");
	endif;
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

Процедура check_pos_ichar() Экспорт
	grammar = new Structure;
	parser = riki.matchiChar("z");
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("z", grammar );
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("z");
	Ожидаем.Что(result.position.position).Равно(2);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	result = riki.parse("Z", grammar );
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("Z");
	Ожидаем.Что(result.position.position).Равно(2);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
КонецПроцедуры

Процедура check_neg_ichar() Экспорт
	
	grammar = new Structure;
	parser = riki.matchiChar("z");
	grammar = riki.Grammar(grammar,"start",parser);
	result = riki.parse("a", grammar );
	
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("Ожидается символ [Z] или [z]");
	else
		Ожидаем.Что(result.message.message).Равно("Expect char [Z] or [z]");
	endif;
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры
#endregion

#region test_range
Процедура check_pos_range() Экспорт
	grammar = new Structure;
	parser = riki.matchRange("a","z");
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("t", grammar );
	
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("t");
	Ожидаем.Что(result.position.position).Равно(2);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_range() Экспорт
	grammar = new Structure;
	parser = riki.matchRange("a","z");
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("A", grammar );
	
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("Ожидается символ из интервала [a-z]");
	else
		Ожидаем.Что(result.message.message).Равно("Expect char from range [a-z]");
	endif;
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

#endregion

#region test_string

Процедура check_pos_string() Экспорт
	grammar = new Structure;
	parser = riki.matchSimpleString("abc");
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("abc", grammar );
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("abc");
	Ожидаем.Что(result.position.position).Равно(4);
	Ожидаем.Что(result.position.column).Равно(4);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_string() Экспорт
	
	grammar = new Structure;
	parser = riki.matchSimpleString("abc");
	grammar = riki.Grammar(grammar,"start",parser);
	result = riki.parse("cba", grammar );
	
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("Ожидается строка ""abc""");
	else
		Ожидаем.Что(result.message.message).Равно("Expect string ""abc""");
	endif;
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

Процедура check_pos_istring() Экспорт
	grammar = new Structure;
	parser = riki.matchiSimpleString("abc");
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("aBc", grammar );
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("aBc");
	Ожидаем.Что(result.position.position).Равно(4);
	Ожидаем.Что(result.position.column).Равно(4);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_istring() Экспорт
	
	grammar = new Structure;
	parser = riki.matchiSimpleString("abc");
	grammar = riki.Grammar(grammar,"start",parser);
	result = riki.parse("CbA", grammar );
	
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("Ожидается регистронезависимая строка ""abc""");
	else
		Ожидаем.Что(result.message.message).Равно("Expect case-insensitive string ""abc""");
	endif;

	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры
#endregion

#region test_seq

Процедура check_pos_seq() Экспорт
	grammar = new Structure;
	parser = riki.matchSeq(riki.matchRange("a","z"), riki.matchRange("0","9"));
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("a1", grammar );
	
	Ожидаем.Что(result.value[0].value,"Корректно прочли символ").Равно("a");
	Ожидаем.Что(result.value[1].value,"Корректно прочли символ").Равно("1");
	Ожидаем.Что(result.position.position).Равно(3);
	Ожидаем.Что(result.position.column).Равно(3);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_seq() Экспорт
	grammar = new Structure;
	parser = riki.matchSeq(riki.matchRange("a","z"), riki.matchRange("0","9"));
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("1z", grammar );
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("Ожидается символ из интервала [a-z]");
	else
		Ожидаем.Что(result.message.message).Равно("Expect char from range [a-z]");
	endif;
	
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

#endregion

#region test_alt

Процедура check_pos_alt() Экспорт
	grammar = new Structure;
	parser = riki.matchAlt(riki.matchRange("a","z"), riki.matchRange("0","9"));
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("a1", grammar );
	
	Ожидаем.Что(result.value ,"Корректно прочли символ").Равно("a");
	Ожидаем.Что(result.position.position).Равно(2);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	result = riki.parse("1", grammar );
	
	Ожидаем.Что(result.value ,"Корректно прочли символ").Равно("1");
	Ожидаем.Что(result.position.position).Равно(2);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
КонецПроцедуры

Процедура check_neg_alt() Экспорт
	grammar = new Structure;
	parser = riki.matchAlt(
				riki.matchRange("a","z"), 
				riki.matchRange("0","9"));
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("A", grammar );
	
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("Ожидается символ из интервала [a-z] or Ожидается символ из интервала [0-9]");
	else
		Ожидаем.Что(result.message.message).Равно("Expect char from range [a-z] or Expect char from range [0-9]");
	endif;
	
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

#endregion

#region test_not

Процедура check_pos_not() Экспорт
	grammar = new Structure;
	parser = riki.matchNot(riki.matchRange( "a","z"));
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("1", grammar );
	
	Ожидаем.Что(result.value,"Корректно отработал not").Равно(Undefined);
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_not() Экспорт
	grammar = new Structure;
	parser = riki.matchNot(riki.matchRange( "a","z"));
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("a", grammar );
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("NOT {Ожидается символ из интервала [a-z]}");
	else
		Ожидаем.Что(result.message.message).Равно("NOT {Expect not char from range [a-z]}");
	endif;
	
	Ожидаем.Что(result.position.position).Равно(2);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

#endregion

#region test_any

Процедура check_pos_any() Экспорт
	grammar = new Structure;
	parser = riki.matchAny();
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("1", grammar );
	
	Ожидаем.Что(result.value ,"Корректно прочли символ").Равно("1");
	Ожидаем.Что(result.position.position).Равно(2);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_any() Экспорт
	grammar = new Structure;
	parser = riki.matchAny();
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("", grammar );
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("Ожидется входной символ");
	else
		Ожидаем.Что(result.message.message).Равно("Expect any char");
	endif;
	
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

#endregion

#region test_eof

Процедура check_pos_eof() Экспорт
	grammar = new Structure;
	parser = riki.matchEOF();
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("", grammar );
	
	Ожидаем.Что(result.value ,"Корректно прочли символ").Равно(Undefined);
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_eof() Экспорт
	grammar = new Structure;
	parser = riki.matchEOF();
	grammar = riki.Grammar(grammar, "start",parser);
	result = riki.parse("1", grammar );
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("Ожидается конец потока");
	else
		Ожидаем.Что(result.message.message).Равно("Expect EOF");
	endif;
	
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

#endregion

#region test_star

Процедура check_pos_star() Экспорт
	grammar = new Structure;
	parser = riki.matchStar(riki.matchChar("a"));
	grammar = riki.Grammar(grammar, "start",parser);

	result = riki.parse("aaa", grammar );
	
	Ожидаем.Что(result.value[0].value ,"Корректно прочли символ").Равно("a");
	Ожидаем.Что(result.value.Count()).Равно(3);
	Ожидаем.Что(result.position.position).Равно(4);
	Ожидаем.Что(result.position.column).Равно(4);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_star() Экспорт
	grammar = new Structure;
	parser = riki.matchStar(riki.matchChar("a"));
	grammar = riki.Grammar(grammar, "start",parser);

	result = riki.parse("123", grammar );
	
	Ожидаем.Что(result.value.Count()).Равно(0);
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

#endregion

#region test_quest

Процедура check_pos_quest() Экспорт
	grammar = new Structure;
	parser = riki.matchQuest(riki.matchChar("a"), undefined);
	grammar = riki.Grammar(grammar, "start",parser);

	result = riki.parse("a", grammar );
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("a");
	Ожидаем.Что(result.position.position).Равно(2);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_quest() Экспорт
	grammar = new Structure;
	parser = riki.matchQuest(riki.matchChar("a"), "figasik");
	grammar = riki.Grammar(grammar, "start",parser);

	result = riki.parse("1", grammar );
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("figasik");
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

#endregion

#region test_plus

Процедура check_pos_plus() Экспорт
	grammar = new Structure;
	parser = riki.matchPlus(riki.matchChar("a"));
	grammar = riki.Grammar(grammar, "start",parser);

	result = riki.parse("aa", grammar );
	
	Ожидаем.Что(result.value[0].value,"Корректно прочли символ").Равно("a");
	Ожидаем.Что(result.value[1].value,"Корректно прочли символ").Равно("a");
	Ожидаем.Что(result.position.position).Равно(3);
	Ожидаем.Что(result.position.column).Равно(3);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_plus() Экспорт
	grammar = new Structure;
	parser = riki.matchPlus(riki.matchChar("a"));
	grammar = riki.Grammar(grammar, "start",parser);

	result = riki.parse("1", grammar );
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("seq [1..-1] {Ожидается символ [a]}");
	else
		Ожидаем.Что(result.message.message).Равно("seq [1..-1] {Expect char [a]}");
	endif;

	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

#endregion

#region test_lookahead

Процедура check_pos_lookahead() Экспорт
	grammar = new Structure;
	parser = riki.matchLookahead(riki.matchChar("a"));
	grammar = riki.Grammar(grammar, "start",parser);

	result = riki.parse("aa", grammar );
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("a");
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_lookahead() Экспорт
	grammar = new Structure;
	parser = riki.matchLookahead(riki.matchChar("a"));
	grammar = riki.Grammar(grammar, "start",parser);

	result = riki.parse("1a", grammar );
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("Ожидается символ [a]");
	else
		Ожидаем.Что(result.message.message).Равно("Expect char [a]");
	endif;
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

#endregion

#region test_plus

Процедура check_pos_fn() Экспорт
	grammar = new Structure;
	parser = riki.matchFn(riki.matchChar("a"), "$$ = 1");
	grammar = riki.Grammar(grammar, "start",parser);

	result = riki.parse("aa", grammar );
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно(1);
	Ожидаем.Что(result.position.position).Равно(2);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	grammar = new Structure;
	parser = riki.matchFn(riki.matchBind(riki.matchChar("a"),"first"), "$$ = $first.value+1");
	grammar = riki.Grammar(grammar, "start",parser);

	result = riki.parse("aa", grammar );
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("a1");
	Ожидаем.Что(result.position.position).Равно(2);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
КонецПроцедуры

Процедура check_neg_fn() Экспорт
	grammar = new Structure;
	parser = riki.matchFn(riki.matchChar("a"), "$$ = 1");
	grammar = riki.Grammar(grammar, "start",parser);

	result = riki.parse("1", grammar );
	
	if CurrentLanguage() = Metadata.Languages.Русский then
		Ожидаем.Что(result.message.message).Равно("Ожидается символ [a]");
	else
		Ожидаем.Что(result.message.message).Равно("Expect char [a]");
	endif;

	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

#endregion




