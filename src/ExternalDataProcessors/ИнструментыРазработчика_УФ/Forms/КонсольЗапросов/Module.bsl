&НаКлиенте
Процедура ПроцедурыПриИзменении(Элемент)
	
	
	ПроцедурыПриИзмененииСервер();
КонецПроцедуры

&НаСервере
Процедура ПроцедурыПриИзмененииСервер()
	
	ХранилищеНастроекДанныхФорм.Сохранить("Объект", "Запросы", РеквизитФормыВЗначение("Запросы"));

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Попытка
		ЗначениеВРеквизитФормы(ХранилищеНастроекДанныхФорм.Загрузить("Объект", "Запросы"),"Запросы");
	Исключение
		Сообщить("не получилоз загрузить предыдущие версии");
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКонсольЗапросов(Команда)
	ТекСтрока = ЭтаФорма.Элементы.Запросы.ТекущиеДанные;
  	Текст = ?(ПустаяСтрока(ТекСтрока.ТекстЗапроса),"выбрать 1",ТекСтрока.ТекстЗапроса);
	КЗ = Новый КонструкторЗапроса(Текст);
	КЗ.Показать(Новый ОписаниеОповещения("ОбновитьЗапрос",ЭтаФорма));	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗапрос(Текст,ДП) Экспорт
	Если Текст <> Неопределено тогда
		ТекСтрока = ЭтаФорма.Элементы.Запросы.ТекущиеДанные;
		ТекСтрока.ТекстЗапроса = Текст;
		ПроцедурыПриИзмененииСервер();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ВыполнитьЗапросНаСервере(знач ТекстЗапроса,знач ПараметрыЗапроса)                            
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Для Каждого П из ПараметрыЗапроса Цикл
		Запрос.УстановитьПараметр(п.Имя,п.значение);	
	КонецЦикла;
	РезультатВ = Запрос.ВыполнитьПакетСПромежуточнымиДанными();
	Результат.Очистить();
	
	Для Каждого р из РезультатВ Цикл	
		Построитель = Новый ПостроительОтчета;
		Построитель.ИсточникДанных  = Новый ОписаниеИсточникаДанных(р);
		Построитель.Вывести(Результат);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьЗапрос(Команда)
	ТекСтрока = ЭтаФорма.Элементы.Запросы.ТекущиеДанные;
	//Попытка
		ВыполнитьЗапросНаСервере(ТекСтрока.ТекстЗапроса,  ТекСтрока.Параметры);
	//Исключение
	//КонецПопытки;
КонецПроцедуры

&НаСервере
Функция ЗаполнитьПараметрыНаСервере(знач ТекстЗапроса)
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	
	С = Новый Соответствие;
	пп = запрос.НайтиПараметры();
	Для Каждого п из пп цикл
		С.Вставить(п.имя,п.ТипЗначения);
	КонецЦикла;
	
	Возврат с; 
КонецФункции

&НаКлиенте
Процедура ЗаполнитьПараметры(Команда)
	ТекСтрока = ЭтаФорма.Элементы.Запросы.ТекущиеДанные;
  	ТекСтрока.Параметры.очистить();
	пп = ЗаполнитьПараметрыНаСервере(ТекСтрока.ТекстЗапроса);
	
	Для каждого п из пп цикл
		сп = ТекСтрока.Параметры.добавить();
		сп.Имя = п.Ключ;
		сп.Типы = п.Значение;
	КонецЦикла;
КонецПроцедуры


&НаСервере
Процедура СписокЗапросовНаСервере()
	Элемент = Элементы.Запросы;
	Если Элемент.Родитель = Элементы.СписокЗапросов Тогда		
		Элементы.Переместить(Элемент,Элементы.Призрак);
	Иначе
		Элементы.Переместить(Элемент,Элементы.СписокЗапросов);
	КонецЕсли;
	// Вставить содержимое обработчика.
КонецПроцедуры


&НаКлиенте
Процедура СписокЗапросов(Команда)
	СписокЗапросовНаСервере();
КонецПроцедуры


&НаКлиенте
Процедура ПереключитьВидимостьПараметров(Команда)
	ПереключитьВидимостьЭлементы(Элементы.ПараметрыГруппа)	
КонецПроцедуры

&НаКлиенте
Процедура ПереключитьВидимостьЭлементы(Элемент)
	Элемент.Видимость = Не Элемент.Видимость;
КонецПроцедуры


&НаКлиенте
Процедура ПереключитьВидимостьТекста(Команда)
	ПереключитьВидимостьЭлементы(Элементы.ТекстЗапроса)
КонецПроцедуры


&НаКлиенте
Процедура ПереключитьВидимостьРезультата(Команда)
	ПереключитьВидимостьЭлементы(Элементы.Результатэ)
КонецПроцедуры


&НаКлиенте
Процедура ОткрытьКонсольЗапросов1(Команда)
	ОткрытьФорму("ВнешняяОбработка.ИнструментыРазработчика_УФ.Форма.КонструкторЗапросов");
КонецПроцедуры


&НаКлиенте
Процедура ЗапросыПараметрыПриАктивизацииСтроки(Элемент)
	Попытка 
		ЭлементФормы = Элементы.ЗапросыПараметрыЗначение;
		ЭлементФормы.ДоступныеТипы = ЭтаФорма.Элементы.ЗапросыПараметры.ТекущиеДанные.Типы;
		ЭлементФормы.ОграничениеТипа = ЭтаФорма.Элементы.ЗапросыПараметры.ТекущиеДанные.Типы;
		ЭлементФормы.СписокВыбора.ТипЗначения = ЭтаФорма.Элементы.ЗапросыПараметры.ТекущиеДанные.Типы;
	Исключение
	КонецПопытки;
КонецПроцедуры

