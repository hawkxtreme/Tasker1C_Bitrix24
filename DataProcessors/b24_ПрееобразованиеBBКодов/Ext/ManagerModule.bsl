﻿ 
 #Область Преобразование

Функция ДанныеПреобразованияBBКодаВФорматированныйДокумент(Знач Текст) Экспорт 
	
	ФорматированныйДокумент = Новый ФорматированныйДокумент; 
	
	//преобразуем простые теги  
	ТаблицаСложныхТегов		= ТаблицаСложныхТегов();
	ТаблицаПростыхТегов 	= ТаблицаПреобразованияПростыхТегов();
	ТаблицаУдалямыхТегов	= ТаблицаУдалямыхТегов();
	
	//добавим переводы строк
	Текст = СтрЗаменить(Текст, Символы.ПС, "<br>");
	
    //обработать сложные теги
	ОбработатьСложныеТеги(Текст, ТаблицаСложныхТегов);
	
	//обработать простые теги
	ОбработатьПростыеТеги(Текст, ТаблицаПростыхТегов);
	
	//обработать удаляемые теги
	ОбработатьУдаляемыеТеги(Текст, ТаблицаУдалямыхТегов);
	
	ФорматированныйДокумент.УстановитьHTML(Текст, Новый Структура());

	
	Данные = Новый Структура();
	Данные.Вставить("ФорматированныйДокумент", ФорматированныйДокумент);
	Данные.Вставить("ТекстHTML", Текст);
	
	Возврат Данные

КонецФункции 

Процедура ОбработатьСложныеТеги(Текст, Таблица)

	Для Каждого Строка Из Таблица Цикл 
		
		КонецПоиска		= СтрНайти(Строка.ИсходныйОткрывающий, "Параметр") - 1;
		СтрокаПоиска 	= Лев(Строка.ИсходныйОткрывающий, КонецПоиска);
		
		ЗаменитьТегСПараметром(Текст, Строка, Нрег(СтрокаПоиска));
		ЗаменитьТегСПараметром(Текст, Строка, ВРег(СтрокаПоиска));
		
		ЗаменитьТег(Текст, Строка.ИсходныйЗакрывающий, Строка.ПриемникЗакрывающий);
		
	КонецЦикла;

КонецПроцедуры

Процедура ОбработатьПростыеТеги(Текст, Таблица)

	Для Каждого Строка Из Таблица Цикл 
		
		ЗаменитьТег(Текст, Строка.ИсходныйОткрывающий, Строка.ПриемникОткрывающий);
		ЗаменитьТег(Текст, Строка.ИсходныйЗакрывающий, Строка.ПриемникЗакрывающий);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьУдаляемыеТеги(Текст, Таблица)

	Для Каждого Строка Из Таблица Цикл 
		
		Если СтрНайти(Строка.ИсходныйОткрывающий, "Параметр") Тогда 
			
			КонецПоиска		= СтрНайти(Строка.ИсходныйОткрывающий, "Параметр") - 1;
			СтрокаПоиска 	= Лев(Строка.ИсходныйОткрывающий, КонецПоиска);
			
			УдалитьТегСПараметром(Текст, Строка, Нрег(СтрокаПоиска));
			УдалитьТегСПараметром(Текст, Строка, ВРег(СтрокаПоиска));
			
		Иначе 
			ЗаменитьТег(Текст, Строка.ИсходныйОткрывающий, "");	
		КонецЕсли;
		
		ЗаменитьТег(Текст, Строка.ИсходныйЗакрывающий, "");	
		
	КонецЦикла;

КонецПроцедуры

Процедура ЗаменитьТег(Текст, Исходный, Приемник)

	Текст = СтрЗаменить(Текст, ВРег(Исходный), Приемник);
	Текст = СтрЗаменить(Текст, Нрег(Исходный), Приемник);
	
КонецПроцедуры 

Процедура ЗаменитьТегСПараметром(Текст, Строка, СтрокаПоискаВРегистре)
	
	ЧислоВхождений			= СтрЧислоВхождений(Текст, СтрокаПоискаВРегистре);
	
	Пока ЧислоВхождений > 0 Цикл 
		
		НачалоТега 			= СтрНайти(Текст, СтрокаПоискаВРегистре,,, 1);
		
		Если НачалоТега > 0 Тогда 
			
			КонецТега			= СтрНайти(Текст, "]",, НачалоТега, 1); 
			ТекстТега			= Сред(Текст, НачалоТега, КонецТега - НачалоТега + 1); 
			
			Параметр			= СтрЗаменить(ТекстТега, СтрокаПоискаВРегистре, "");
			Параметр			= СтрЗаменить(Параметр, "]", ""); 
			Параметр			= СтрЗаменить(Параметр, """", ""); 
			
			ПриемникРезультат 	= СтрЗаменить(Строка.ПриемникОткрывающий, "Параметр", Параметр); 
			
			Текст 				= СтрЗаменить(Текст, ТекстТега, ПриемникРезультат); 
			ЧислоВхождений		= СтрЧислоВхождений(Текст, СтрокаПоискаВРегистре); 
			
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

Процедура УдалитьТегСПараметром(Текст, Строка, СтрокаПоискаВРегистре)
	
	ЧислоВхождений			= СтрЧислоВхождений(Текст, СтрокаПоискаВРегистре);
	
	Пока ЧислоВхождений > 0 Цикл 
		
		НачалоТега 			= СтрНайти(Текст, СтрокаПоискаВРегистре,,, 1);
		
		Если НачалоТега > 0 Тогда 
			
			КонецТега			= СтрНайти(Текст, "]",, НачалоТега, 1); 
			ТекстТега			= Сред(Текст, НачалоТега, КонецТега - НачалоТега + 1); 

			Текст 				= СтрЗаменить(Текст, ТекстТега, "");    
			ЧислоВхождений		= СтрЧислоВхождений(Текст, СтрокаПоискаВРегистре);
			
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область Настройки

Функция ТаблицаСложныхТегов()
	
	Таблица 		= ПреобразоватьТабличныйДокументВТаблицуЗначений(ПолучитьМакет("СложныеТеги"));	
	УдалитьПустыСтрокиНастроек(Таблица);
	
	Возврат Таблица
	
КонецФункции

Функция ТаблицаПреобразованияПростыхТегов()
	
	Таблица = ПреобразоватьТабличныйДокументВТаблицуЗначений(ПолучитьМакет("ПростыеТеги"));	
	УдалитьПустыСтрокиНастроек(Таблица);
	
	Возврат Таблица
	
КонецФункции 

Функция ТаблицаУдалямыхТегов()
	
	Таблица = ПреобразоватьТабличныйДокументВТаблицуЗначений(ПолучитьМакет("УдаляемыеТеги"));	
	УдалитьПустыСтрокиНастроек(Таблица);
	
	Возврат Таблица
	
КонецФункции 

#КонецОбласти

#Область Служебные

Процедура УдалитьПустыСтрокиНастроек(Таблица)
	
	МассивУдаления 	= Новый Массив;
	
	Для Каждого Строка Из Таблица Цикл 
		Если Не ЗначениеЗаполнено(Строка.ИсходныйОткрывающий) Тогда 
			МассивУдаления.Добавить(Строка);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого Строка Из МассивУдаления Цикл 
		Таблица.Удалить(Строка);
	КонецЦикла;

КонецПроцедуры 

Функция ПреобразоватьТабличныйДокументВТаблицуЗначений(ТабДокумент)

    ПоследняяСтрока 	= ТабДокумент.ВысотаТаблицы;
    ПоследняяКолонка 	= ТабДокумент.ШиринаТаблицы;
    ОбластьЯчеек 		= ТабДокумент.Область(1, 1, ПоследняяСтрока, ПоследняяКолонка); 
	
    ИсточникДанных 		= Новый ОписаниеИсточникаДанных(ОбластьЯчеек);
	
	ПостроительОтчета 	= Новый ПостроительОтчета;
    ПостроительОтчета.ИсточникДанных = ИсточникДанных;
    ПостроительОтчета.Выполнить();
	
    Возврат ПостроительОтчета.Результат.Выгрузить()

КонецФункции

#КонецОбласти