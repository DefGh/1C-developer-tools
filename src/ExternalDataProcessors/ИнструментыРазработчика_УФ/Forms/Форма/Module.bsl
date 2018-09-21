
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Обр = РеквизитФормыВЗначение("Объект");
	Макет = Обр.ПолучитьМакет("Инструменты");
	
	кп = Элементы.МояКП;
	
	Если Ложь Тогда 
		Макет = Новый ТабличныйДокумент;
	КонецЕсли;
	
	Строка = 2;
	Пока Строка <= Макет.ВысотаТаблицы Цикл
		К = ЭтаФорма.Команды.Добавить(Макет.Область(Строка,1).Текст);
		К.Заголовок = Макет.Область(Строка,2).Текст;
		К.Картинка = Макет.Область(Строка,3).Картинка;
		К.Действие = "ОткрытьФормуИнструмента";
		Кнопка = ЭтаФорма.Элементы.Добавить(Макет.Область(Строка,1).Текст,Тип("КнопкаФормы"),кп);
		Кнопка.Картинка =  Макет.Область(Строка,3).Картинка;
		Кнопка.Отображение = ОтображениеКнопки.Картинка;
		Кнопка.ИмяКоманды = К.Имя;	
		Строка = Строка + 1;	
	КонецЦикла;
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура ОткрытьФормуИнструмента(Команда)
	Форма = ПолучитьФорму("ВнешняяОбработка.ИнструментыРазработчика_УФ.Форма."+Команда.Имя);
	//Форма.заголовок = Команда.Заголовок;
	Форма.Открыть();
КонецПроцедуры

&НаКлиенте
Процедура Вертикально_Горизонтально(Команда)
	если Элементы.МояКП.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная ТОгда 
		Элементы.МояКП.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Горизонтальная;
	иначе
		Элементы.МояКП.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	КонецЕсли;	
	Элементы.ПолнаяКП.Группировка =  Элементы.МояКП.Группировка ;
КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытии(Отказ)
    ЗакрыватьПриВыборе = Ложь;
    ЗакрыватьПриЗакрытииВладельца = Истина;
    //ЗакрепитьСправа после открытия формы;
    ПодключитьОбработчикОжидания("ЗакрепитьСправа",0.1,Истина);
КонецПроцедуры

&НаКлиенте
Процедура ЗакрепитьСправа()
    Если ЭтаФорма.ВводДоступен() Тогда
        WSHShell = Новый COMОбъект("WScript.Shell");
        WSHShell.SendKeys("%");
        WSHShell.SendKeys("{DOWN 5}");
        WSHShell.SendKeys("{RIGHT}");
        WSHShell.SendKeys("{UP 5}");
        WSHShell.SendKeys("{ENTER}");
        ОтключитьОбработчикОжидания("ЗакрепитьСправа");
    КонецЕсли;
КонецПроцедуры;

