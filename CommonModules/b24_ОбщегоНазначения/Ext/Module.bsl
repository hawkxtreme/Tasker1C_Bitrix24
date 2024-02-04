﻿
Функция ПолучитьСоответствиеEmailПользователь() Экспорт 
	
	Соответствие = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Вид", Справочники.ВидыКонтактнойИнформации.EmailПользователя);
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ПользователиКонтактнаяИнформация.Ссылка КАК Ссылка,
	|	ПользователиКонтактнаяИнформация.АдресЭП КАК АдресЭП
	|ИЗ
	|	Справочник.Пользователи.КонтактнаяИнформация КАК ПользователиКонтактнаяИнформация
	|ГДЕ
	|	ПользователиКонтактнаяИнформация.Вид = &Вид";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Соответствие[ВыборкаДетальныеЗаписи.АдресЭП] = ВыборкаДетальныеЗаписи.Ссылка;		
	КонецЦикла;
		
	Возврат Соответствие
	
КонецФункции 

Функция ПолучитьСоответствиеIdКонтрагент() Экспорт 
	
	Соответствие = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Вид", Справочники.ВидыКонтактнойИнформации.узEmailКонтрагенты);
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	Контрагенты.Ссылка КАК Ссылка,
	|	Контрагенты.b24_ID КАК b24_ID
	|ИЗ
	|	Справочник.узКонтрагенты КАК Контрагенты";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Соответствие[ВыборкаДетальныеЗаписи.b24_ID] = ВыборкаДетальныеЗаписи.Ссылка;		
	КонецЦикла;
		
	Возврат Соответствие
	
КонецФункции