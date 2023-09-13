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
	НаборТестов.НачатьГруппу("lookahead");
	НаборТестов.Добавить("check_pos_lookahead");
	НаборТестов.Добавить("check_neg_lookahead");
	НаборТестов.НачатьГруппу("quest");
	НаборТестов.Добавить("check_pos_quest");
	НаборТестов.Добавить("check_neg_quest");
	НаборТестов.НачатьГруппу("star");
	НаборТестов.Добавить("check_pos_star");
	НаборТестов.Добавить("check_neg_star");
	НаборТестов.НачатьГруппу("plus");
	НаборТестов.Добавить("check_pos_plus_1");
	НаборТестов.Добавить("check_pos_plus_2");
	НаборТестов.Добавить("check_neg_plus");
	НаборТестов.НачатьГруппу("fn");
	НаборТестов.Добавить("check_pos_fn_1");
	НаборТестов.Добавить("check_pos_fn_2");
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
	
	
	Ожидаем.Что(result.message.message).Равно("Expect char 'z'");
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
	
	
	Ожидаем.Что(result.message.message).Равно("Expect char 'z' or 'Z'");
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры
#endregion

#region test_range
Процедура check_pos_range() Экспорт
	
	parser = riki.matchRange("a","z");
	grammar = riki.Grammar("start",parser);
	result = riki.parse("t", grammar );
	
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("t");
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_range() Экспорт
	
	parser = riki.matchRange("a","z");
	grammar = riki.Grammar("start",parser);
	result = riki.parse("A", grammar );
	
	
	Ожидаем.Что(result.message).Равно("Expect char from range [a-z]");
	Ожидаем.Что(result.position.position).Равно(0);
	Ожидаем.Что(result.position.column).Равно(1);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("failure");
	
	
КонецПроцедуры

#endregion


/// end