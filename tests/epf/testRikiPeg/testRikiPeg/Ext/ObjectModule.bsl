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
	НаборТестов.НачатьГруппу("Простые парсеры");
	НаборТестов.Добавить("check_pos_char");
	НаборТестов.Добавить("check_neg_char");
	
	НаборТестов.Добавить("check_pos_range");
	НаборТестов.Добавить("check_neg_range");

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
	
	parser = riki.matchChar("z");
	grammar = riki.Grammar("start",parser);
	result = riki.parse("z", grammar );
	
	
	Ожидаем.Что(result.value,"Корректно прочли символ").Равно("z");
	Ожидаем.Что(result.position.position).Равно(1);
	Ожидаем.Что(result.position.column).Равно(2);
	Ожидаем.Что(result.position.line).Равно(1);
	Ожидаем.Что(result.type).Равно("success");
	
	
КонецПроцедуры

Процедура check_neg_char() Экспорт
	
	parser = riki.matchChar("z");
	grammar = riki.Grammar("start",parser);
	result = riki.parse("a", grammar );
	
	
	Ожидаем.Что(result.message).Равно("Expect char 'z'");
	Ожидаем.Что(result.position.position).Равно(0);
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
