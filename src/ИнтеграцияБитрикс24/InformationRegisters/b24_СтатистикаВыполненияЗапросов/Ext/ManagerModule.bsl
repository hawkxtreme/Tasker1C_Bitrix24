﻿
Функция Записать(Дата, Сайт, Метод) Экспорт 
	
	НаборЗаписей 			= РегистрыСведений.b24_СтатистикаВыполненияЗапросов.СоздатьНаборЗаписей(); 
	НаборЗаписей.Отбор.Сайт.Установить(Сайт);
	НаборЗаписей.Отбор.Дата.Установить(Дата);
	НаборЗаписей.Отбор.Метод.Установить(Метод);
	НаборЗаписей.Прочитать();
	
	Если НаборЗаписей.Количество() = 0 Тогда 
		
		Запись				= НаборЗаписей.Добавить();
		Запись.Дата 		= Дата;
		Запись.Сайт 		= Сайт;
		Запись.Метод 		= Метод;  
		Запись.Количество 	= 1;
		
	Иначе
		
		Запись				= НаборЗаписей[0];		
		Запись.Количество 	= Запись.Количество + 1;  
		
	КонецЕсли;
	
	НаборЗаписей.Записать();

КонецФункции