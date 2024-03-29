﻿ 
Функция ПолучитьОбъектыОбмена() Экспорт 
	
	МасссивТиповОбъектов = Новый Массив;
	МасссивТиповОбъектов.Добавить(Тип("СправочникСсылка.ИдентификаторыОбъектовМетаданных"));
	МасссивТиповОбъектов.Добавить(Тип("СправочникСсылка.ИдентификаторыОбъектовРасширений"));  
	
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("Объект", Новый ОписаниеТипов(МасссивТиповОбъектов));
	Таблица.Колонки.Добавить("Загрузка", Новый ОписаниеТипов("Булево"));
	Таблица.Колонки.Добавить("Выгрузка", Новый ОписаниеТипов("Булево"));  
	
	//b24_Подразделения
	НоваяСтрока 			= Таблица.Добавить();
	НоваяСтрока.Объект 		= ОбщегоНазначения.ИдентификаторОбъектаМетаданных(Метаданные.Справочники.b24_Подразделения);
	НоваяСтрока.Загрузка 	= Истина;
	НоваяСтрока.Выгрузка 	= Ложь;
	
	//узКонтрагенты
	НоваяСтрока 			= Таблица.Добавить();
	НоваяСтрока.Объект 		= ОбщегоНазначения.ИдентификаторОбъектаМетаданных(Метаданные.Справочники.узКонтрагенты);
	НоваяСтрока.Загрузка 	= Истина;
	НоваяСтрока.Выгрузка 	= Ложь;
	
	//Пользователи
	НоваяСтрока 			= Таблица.Добавить();
	НоваяСтрока.Объект 		= ОбщегоНазначения.ИдентификаторОбъектаМетаданных(Метаданные.Справочники.Пользователи);
	НоваяСтрока.Загрузка 	= Истина;
	НоваяСтрока.Выгрузка 	= Ложь;
	
	//узЗадачи
	НоваяСтрока 			= Таблица.Добавить();
	НоваяСтрока.Объект 		= ОбщегоНазначения.ИдентификаторОбъектаМетаданных(Метаданные.Справочники.узЗадачи);
	НоваяСтрока.Загрузка 	= Истина;
	НоваяСтрока.Выгрузка 	= Истина; 
	
	Возврат Таблица
	
КонецФункции
 
Функция ПолучитьАктивные() Экспорт 
	
	Массив = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	b24_СайтИнтеграции.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.b24_СайтИнтеграции КАК b24_СайтИнтеграции
		|ГДЕ
		|	b24_СайтИнтеграции.Активно
		|	И НЕ b24_СайтИнтеграции.ПометкаУдаления";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Массив.Добавить(ВыборкаДетальныеЗаписи.Ссылка);
	КонецЦикла;
	
	Возврат Массив
	
КонецФункции

Функция ПолучитьВсе() Экспорт 
	
	Массив = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	b24_СайтИнтеграции.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.b24_СайтИнтеграции КАК b24_СайтИнтеграции";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Массив.Добавить(ВыборкаДетальныеЗаписи.Ссылка);
	КонецЦикла;
	
	Возврат Массив
	
КонецФункции

Функция ПолучитьПараметрыПодключения(Сайт) Экспорт 

	Соответствие = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	b24_СайтИнтеграции.URL КАК URL,
		|	b24_СайтИнтеграции.ИдентификаторПользователя КАК ИдентификаторПользователя,
		|	b24_СайтИнтеграции.СекретныйКод КАК СекретныйКод,
		|	ЕСТЬNULL(b24_НастройкиИнтеграций.МаксимальноеКоличествоЗапросовПередЗадержкой, 0) КАК МаксимальноеКоличествоЗапросовПередЗадержкой,
		|	ЕСТЬNULL(b24_НастройкиИнтеграций.Задержка, 0) КАК Задержка
		|ИЗ
		|	Справочник.b24_СайтИнтеграции КАК b24_СайтИнтеграции
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.b24_НастройкиИнтеграций КАК b24_НастройкиИнтеграций
		|		ПО b24_СайтИнтеграции.Ссылка = b24_НастройкиИнтеграций.Сайт
		|ГДЕ
		|	b24_СайтИнтеграции.Ссылка = &Сайт
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	b24_СайтИнтеграцииФильтры_Задачи.Ключ КАК Ключ,
		|	b24_СайтИнтеграцииФильтры_Задачи.ВидСравнения КАК ВидСравнения,
		|	b24_СайтИнтеграцииФильтры_Задачи.Значение КАК Значение
		|ИЗ
		|	Справочник.b24_СайтИнтеграции.Фильтры_Задачи КАК b24_СайтИнтеграцииФильтры_Задачи
		|ГДЕ
		|	b24_СайтИнтеграцииФильтры_Задачи.Ссылка = &Сайт
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	b24_СайтИнтеграцииОбязательныеРеквизиты_Задачи.Ключ КАК Ключ,
		|	b24_СайтИнтеграцииОбязательныеРеквизиты_Задачи.Значение КАК Значение
		|ИЗ
		|	Справочник.b24_СайтИнтеграции.ОбязательныеРеквизиты_Задачи КАК b24_СайтИнтеграцииОбязательныеРеквизиты_Задачи
		|ГДЕ
		|	b24_СайтИнтеграцииОбязательныеРеквизиты_Задачи.Ссылка = &Сайт
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	b24_СайтИнтеграцииФильтры_Пользователи.Ключ КАК Ключ,
		|	b24_СайтИнтеграцииФильтры_Пользователи.Значение КАК Значение
		|ИЗ
		|	Справочник.b24_СайтИнтеграции.Фильтры_Пользователи КАК b24_СайтИнтеграцииФильтры_Пользователи
		|ГДЕ
		|	b24_СайтИнтеграцииФильтры_Пользователи.Ссылка = &Сайт
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	b24_СайтИнтеграцииОбъектыОбмена.Объект КАК Объект,
		|	b24_СайтИнтеграцииОбъектыОбмена.Загрузка КАК Загрузка,
		|	b24_СайтИнтеграцииОбъектыОбмена.Выгрузка КАК Выгрузка
		|ИЗ
		|	Справочник.b24_СайтИнтеграции.ОбъектыОбмена КАК b24_СайтИнтеграцииОбъектыОбмена
		|ГДЕ
		|	b24_СайтИнтеграцииОбъектыОбмена.Ссылка = &Сайт
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	b24_СайтИнтеграцииПользовательскиеПоля_Задачи.ВнешнийПуть КАК ВнешнийПуть,
		|	b24_СайтИнтеграцииПользовательскиеПоля_Задачи.Тип КАК Тип,
		|	b24_СайтИнтеграцииПользовательскиеПоля_Задачи.ВнутреннийПуть КАК ВнутреннийПуть
		|ИЗ
		|	Справочник.b24_СайтИнтеграции.ПользовательскиеПоля_Задачи КАК b24_СайтИнтеграцииПользовательскиеПоля_Задачи
		|ГДЕ
		|	b24_СайтИнтеграцииПользовательскиеПоля_Задачи.Ссылка = &Сайт";
	
	Запрос.УстановитьПараметр("Сайт", Сайт);
	
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	
	//Основные настройки
	ВыборкаДетальныеЗаписи = РезультатЗапроса[0].Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		Соответствие["Сайт"] 											= Сайт;
		Соответствие["ДатаПолученияНастроек"]							= ТекущаяДатаСеанса();
		Соответствие["URL"] 											= ВыборкаДетальныеЗаписи.URL;
		Соответствие["ИдентификаторПользователя"] 						= ВыборкаДетальныеЗаписи.ИдентификаторПользователя;
		Соответствие["СекретныйКод"] 									= ВыборкаДетальныеЗаписи.СекретныйКод;
		Соответствие["МаксимальноеКоличествоЗапросовПередЗадержкой"]	= ВыборкаДетальныеЗаписи.МаксимальноеКоличествоЗапросовПередЗадержкой;
		Соответствие["Задержка"] 										= ВыборкаДетальныеЗаписи.Задержка;
		
	КонецЦикла;
	
	//Фильтры задачи
	ВыборкаДетальныеЗаписи 		= РезультатЗапроса[1].Выбрать();
	ТаблицаФильтрыЗадачи 		= b24_Интеграция.ИнициализироватьТаблицуФильтров();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		b24_Интеграция.ДобавитьФильтр(ТаблицаФильтрыЗадачи, ВыборкаДетальныеЗаписи.Ключ,  ВыборкаДетальныеЗаписи.Значение,  ВыборкаДетальныеЗаписи.ВидСравнения);  
	КонецЦикла;
	
	Соответствие["ФильтрыЗадачи"] = ТаблицаФильтрыЗадачи;
	
	//Обязательные реквизиты задачи
	ВыборкаДетальныеЗаписи 			= РезультатЗапроса[2].Выбрать();
	СоответствиеФильтрыРеквизиты 	= Новый Соответствие;
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СоответствиеФильтрыРеквизиты[ВыборкаДетальныеЗаписи.Ключ] = ВыборкаДетальныеЗаписи.Значение;
	КонецЦикла;
	
	Соответствие["ОбязательныеРеквизитыЗадачи"] = СоответствиеФильтрыРеквизиты;
	
	//Фильтры пользователи
	ВыборкаДетальныеЗаписи 				= РезультатЗапроса[3].Выбрать();
	СоответствиеФильтрыПользователи 	= Новый Соответствие;
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СоответствиеФильтрыПользователи[ВыборкаДетальныеЗаписи.Ключ] = ВыборкаДетальныеЗаписи.Значение;
	КонецЦикла;
	
	Соответствие["ФильтрыПользователи"] = СоответствиеФильтрыПользователи; 
	
	//ОбъектыОбмена
	ВыборкаДетальныеЗаписи 				= РезультатЗапроса[4].Выбрать(); 
	СоответствиеОбъектыОбмена		 	= Новый Соответствие;

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СоответствиеОбъектыОбмена[ВыборкаДетальныеЗаписи.Объект] = Новый Структура("Загрузка, Выгрузка", ВыборкаДетальныеЗаписи.Загрузка, ВыборкаДетальныеЗаписи.Выгрузка);
	КонецЦикла;
	
	Соответствие["ОбъектыОбмена"] = СоответствиеОбъектыОбмена; 
	
	//ПользовательскиеПоля_Задачи   
	ВыборкаДетальныеЗаписи 							= РезультатЗапроса[5].Выбрать();  
	СоответствиеПользовательскиеПоляЗадачи		 	= Новый Соответствие;  
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СоответствиеПользовательскиеПоляЗадачи[ВыборкаДетальныеЗаписи.ВнешнийПуть] = Новый Структура("Тип, ВнутреннийПуть", ВыборкаДетальныеЗаписи.Тип, ВыборкаДетальныеЗаписи.ВнутреннийПуть);
	КонецЦикла;   
	
	Соответствие["ПользовательскиеПоляЗадачи"] = СоответствиеПользовательскиеПоляЗадачи; 
	
	Возврат Соответствие
	
КонецФункции