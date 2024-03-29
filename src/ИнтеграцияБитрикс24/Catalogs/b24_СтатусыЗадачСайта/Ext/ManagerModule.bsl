﻿
Процедура ИнициализироватьСтатусыЗадачСайта(Сайт) Экспорт 
	
	Отказ = Ложь;
	
	//проверяем что требуется обновление
	Если Не ЗначениеЗаполнено(Сайт) Тогда 
		ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю("Не заполнен сайт", Отказ);
	КонецЕсли;         
	
	Если Не Отказ Тогда 
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	b24_СтатусыЗадачСайта.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.b24_СтатусыЗадачСайта КАК b24_СтатусыЗадачСайта
		|ГДЕ
		|	b24_СтатусыЗадачСайта.Владелец = &Владелец
		|	И НЕ b24_СтатусыЗадачСайта.ПометкаУдаления";
		
		Запрос.УстановитьПараметр("Владелец", Сайт);
		
		РезультатЗапроса = Запрос.Выполнить();  
		
		Если Не РезультатЗапроса.Пустой() Тогда 
			ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю("Есть заполненные элементы. Инициализаций не выполнена", Отказ);
		КонецЕсли;
		
	КонецЕсли;
	
	//инициализируем данные 
	Если Не Отказ Тогда 
		
		//METASTATE_VIRGIN_NEW
		ОбъектСтатус 						= Справочники.b24_СтатусыЗадачСайта.СоздатьЭлемент();
		ОбъектСтатус.Владелец				= Сайт;
		ОбъектСтатус.Наименование 			= "Новая задача (не просмотрена)";
		ОбъектСтатус.ЧисловоеЗначение 		= - 2;
		ОбъектСтатус.Статус					= Справочники.узСтатусыЗадачи.Зарегистрирована;   
		ОбъектСтатус.ЗагружатьИзБитрикс24 	= Истина;
		ОбъектСтатус.Записать();
		
		//METASTATE_EXPIRED
		ОбъектСтатус 						= Справочники.b24_СтатусыЗадачСайта.СоздатьЭлемент(); 
		ОбъектСтатус.Владелец				= Сайт;
		ОбъектСтатус.Наименование 			= "Задача просрочена";
		ОбъектСтатус.ЧисловоеЗначение 		= - 1;
		ОбъектСтатус.Статус					= Справочники.узСтатусыЗадачи.ПустаяСсылка();    
		ОбъектСтатус.ЗагружатьИзБитрикс24 	= Ложь;
		ОбъектСтатус.Записать();
		
		//METASTATE_EXPIRED_SOON
		ОбъектСтатус 						= Справочники.b24_СтатусыЗадачСайта.СоздатьЭлемент();
		ОбъектСтатус.Владелец				= Сайт;
		ОбъектСтатус.Наименование 			= "Задача почти просрочена";
		ОбъектСтатус.ЧисловоеЗначение 		= - 3;
		ОбъектСтатус.Статус					= Справочники.узСтатусыЗадачи.ПустаяСсылка();  
		ОбъектСтатус.ЗагружатьИзБитрикс24 	= Ложь;
		
		ОбъектСтатус.Записать();
		
		//STATE_NEW
		ОбъектСтатус 						= Справочники.b24_СтатусыЗадачСайта.СоздатьЭлемент();
		ОбъектСтатус.Владелец				= Сайт;
		ОбъектСтатус.Наименование 			= "Новая задача. (Не используется)";
		ОбъектСтатус.ЧисловоеЗначение 		= 1;
		ОбъектСтатус.Статус					= Справочники.узСтатусыЗадачи.Зарегистрирована;   
		ОбъектСтатус.ЗагружатьИзБитрикс24 	= Истина;
		ОбъектСтатус.Записать();
		
		//STATE_PENDING
		ОбъектСтатус 						= Справочники.b24_СтатусыЗадачСайта.СоздатьЭлемент();
		ОбъектСтатус.Владелец				= Сайт;
		ОбъектСтатус.Наименование 			= "Задача принята ответственным. (Не используется)";
		ОбъектСтатус.ЧисловоеЗначение 		= 2;
		ОбъектСтатус.Статус					= Справочники.узСтатусыЗадачи.Зарегистрирована;     
		ОбъектСтатус.ЗагружатьИзБитрикс24 	= Истина;
		ОбъектСтатус.Записать();
		
		//STATE_IN_PROGRESS
		ОбъектСтатус 						= Справочники.b24_СтатусыЗадачСайта.СоздатьЭлемент();  
		ОбъектСтатус.Владелец				= Сайт;
		ОбъектСтатус.Наименование 			= "Задача выполняется";
		ОбъектСтатус.ЧисловоеЗначение 		= 3;
		ОбъектСтатус.Статус					= Справочники.узСтатусыЗадачи.ВПроцессеВыполнения;     
		ОбъектСтатус.ЗагружатьИзБитрикс24 	= Ложь;  	
		ОбъектСтатус.Записать();
		
		//STATE_SUPPOSEDLY_COMPLETED
		ОбъектСтатус 						= Справочники.b24_СтатусыЗадачСайта.СоздатьЭлемент();  
		ОбъектСтатус.Владелец				= Сайт;
		ОбъектСтатус.Наименование 			= "Условно завершена (ждет контроля постановщиком)";
		ОбъектСтатус.ЧисловоеЗначение 		= 4;
		ОбъектСтатус.Статус					= Справочники.узСтатусыЗадачи.НаТестированииПоказПользователям;  
		ОбъектСтатус.ЗагружатьИзБитрикс24 	= Ложь;  	
		ОбъектСтатус.Записать();
		
		//STATE_COMPLETED
		ОбъектСтатус 						= Справочники.b24_СтатусыЗадачСайта.СоздатьЭлемент();  
		ОбъектСтатус.Владелец				= Сайт;
		ОбъектСтатус.Наименование 			= "Задача завершена";
		ОбъектСтатус.ЧисловоеЗначение 		= 5;
		ОбъектСтатус.Статус					= Справочники.узСтатусыЗадачи.Готово; 
		ОбъектСтатус.ЗагружатьИзБитрикс24 	= Истина;  	
		ОбъектСтатус.Записать();
		
		//STATE_DEFERRED
		ОбъектСтатус 						= Справочники.b24_СтатусыЗадачСайта.СоздатьЭлемент();
		ОбъектСтатус.Владелец				= Сайт;
		ОбъектСтатус.Наименование 			= "Задача отложена";
		ОбъектСтатус.ЧисловоеЗначение 		= 6;
		ОбъектСтатус.Статус					= Справочники.узСтатусыЗадачи.Отложена;  
		ОбъектСтатус.ЗагружатьИзБитрикс24 	= Ложь;  	
		ОбъектСтатус.Записать();
		
		//STATE_DECLINED
		ОбъектСтатус 						= Справочники.b24_СтатусыЗадачСайта.СоздатьЭлемент(); 
		ОбъектСтатус.Владелец				= Сайт;
		ОбъектСтатус.Наименование 			= "Задача отклонена ответственным. (Не используется)";
		ОбъектСтатус.ЧисловоеЗначение 		= 7;
		ОбъектСтатус.Статус					= Справочники.узСтатусыЗадачи.Отменена;  
		ОбъектСтатус.ЗагружатьИзБитрикс24 	= Истина;  	
		ОбъектСтатус.Записать();
				
	КонецЕсли;
	
КонецПроцедуры   

Функция ПолучитьНастройкиСтатусовПоМассивуСайтов(МассивСайтов) Экспорт 
	
	Соответствие = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	b24_СтатусыЗадачСайта.Владелец КАК Владелец,
		|	b24_СтатусыЗадачСайта.ЧисловоеЗначение КАК ЧисловоеЗначение,
		|	b24_СтатусыЗадачСайта.Статус КАК Статус,
		|	b24_СтатусыЗадачСайта.ЗагружатьИзБитрикс24 КАК ЗагружатьИзБитрикс24
		|ИЗ
		|	Справочник.b24_СтатусыЗадачСайта КАК b24_СтатусыЗадачСайта
		|ИТОГИ ПО
		|	Владелец";
	
	РезультатЗапроса 	= Запрос.Выполнить();
	ВыборкаСайт 		= РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	Пока ВыборкаСайт.Следующий() Цикл
		
		СоответствиеНастроекСайта 	= Новый Соответствие;
		ВыборкаДетальныеЗаписи 		= ВыборкаСайт.Выбрать();   
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл  
			
			ДанныеСтатуса = Новый Структура();
			ДанныеСтатуса.Вставить("Статус", ВыборкаДетальныеЗаписи.Статус);
			ДанныеСтатуса.Вставить("ЗагружатьИзБитрикс24", ВыборкаДетальныеЗаписи.ЗагружатьИзБитрикс24);    
			
			СоответствиеНастроекСайта[ВыборкаДетальныеЗаписи.ЧисловоеЗначение] = ДанныеСтатуса;	
			
		КонецЦикла;		
		
		Соответствие[ВыборкаСайт.Владелец] = СоответствиеНастроекСайта;
		
	КонецЦикла;
	
	Возврат Соответствие
	
КонецФункции