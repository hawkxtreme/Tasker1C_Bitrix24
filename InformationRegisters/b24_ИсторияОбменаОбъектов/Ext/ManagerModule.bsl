﻿
Процедура Записать(Сайт, Объект, Событие) Экспорт 

	МенеджерЗаписи 			= РегистрыСведений.b24_ИсторияОбменаОбъектов.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Период 	= ТекущаяДатаСеанса();
	МенеджерЗаписи.Сайт 	= Сайт;
	МенеджерЗаписи.Объект 	= Объект;
	МенеджерЗаписи.Событие 	= Событие;
	МенеджерЗаписи.Записать();
	
КонецПроцедуры