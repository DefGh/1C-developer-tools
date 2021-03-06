
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Дерево = РеквизитФормыВЗначение("ТаблицаДанных");
	
	НаполнитьСтроки(Дерево,БиблиотекаКартинок.Справочник,"Справочники",Метаданные.Справочники);
	
	НаполнитьСтроки(Дерево,БиблиотекаКартинок.Документ,"Документы",Метаданные.Документы);
		
	НаполнитьСтроки(Дерево,БиблиотекаКартинок.РегистрСведений,"РегистрыСведений",Метаданные.РегистрыСведений);
	
	НаполнитьСтроки(Дерево,БиблиотекаКартинок.БизнесПроцесс,"БизнесПроцессы",Метаданные.БизнесПроцессы);
	
	НаполнитьСтроки(Дерево,БиблиотекаКартинок.Задача,"Задачи",Метаданные.Задачи);
	
	//НаполнитьСтроки(Дерево,БиблиотекаКартинок.ПланСчетов,"ПланыСчетов",Метаданные.ПланыСчетов);
	//
	//НаполнитьСтроки(Дерево,БиблиотекаКартинок.ПланВидовХарактеристик,"ПланыВидовХарактеристик",Метаданные.ПланыВидовХарактеристик);

	ЗначениеВРеквизитФормы(Дерево,"ТаблицаДанных");
	//Вставить содержимое обработчика
КонецПроцедуры

Процедура НаполнитьСтроки(Дерево,Картинка,ИмяГоловногоТипа,КоллекцияМетаданных)
	СтрокаТипаМетаднных = Дерево.Строки.Добавить();
	СтрокаТипаМетаднных.Тип = ИмяГоловногоТипа;
	СтрокаТипаМетаднных.Картинка = Картинка;
	
	Для Каждого ОбМтд из КоллекцияМетаданных Цикл
		Стр = СтрокаТипаМетаднных.Строки.Добавить();
		Стр.Тип = ОбМтд.Имя;
		Стр.Картинка = Картинка;
		НастройкиИсторииДанных = ИсторияДанных.ПолучитьНастройки(ОбМтд);
		Если не НастройкиИсторииДанных = Неопределено Тогда
			Стр.Использование = НастройкиИсторииДанных.Использование;
		Иначе
			Стр.Использование = ОбМтд.ИсторияДанных = Метаданные.СвойстваОбъектов.ИспользованиеИсторииДанных.Использовать;
		КонецЕсли;
		Стр.мтд = ОбМТД.ПОлноеИмя();
	КонецЦикла;                	
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	СохранитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура СохранитьНаСервере()
	Для Каждого об из РеквизитФормыВЗначение("ТаблицаДанных").Строки Цикл
		Для Каждого ОбМтд из об.Строки Цикл
			Мтд = Метаданные.НайтиПоПолномуИмени(ОбМтд.мтд);
			//@skip-warning
			ТекНастройкиИсторииДанных = ИсторияДанных.ПолучитьНастройки(Мтд);
			
			Использование = ?(ТекНастройкиИсторииДанных = Неопределено,
			Мтд.ИсторияДанных = Метаданные.СвойстваОбъектов.ИспользованиеИсторииДанных.Использовать,
			ТекНастройкиИсторииДанных.Использование);
			
			Если Использование <> ОбМтд.Использование тогда
				Настройка = новый НастройкиИсторииДанных;
				Настройка.Использование = ОбМтд.Использование;
				//@skip-warning
				ИсторияДанных.УстановитьНастройки(Мтд,Настройка);
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаДанныхИспользованиеПриИзменении(Элемент)
	ТекСтрока = Элементы.ТаблицаДанных.ТекущаяСтрока;
	ТекСтрока = ТаблицаДанных.НайтиПоИдентификатору(ТекСтрока);
	Если ТекСтрока.ПолучитьРодителя() = Неопределено Тогда 
		Для Каждого Стр из ТекСтрока.ПолучитьЭлементы() Цикл
			Стр.Использование = ТекСтрока.Использование;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры
