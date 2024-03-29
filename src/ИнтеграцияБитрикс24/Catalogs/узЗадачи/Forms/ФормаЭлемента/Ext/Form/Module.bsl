﻿
&НаСервере
Процедура b24_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	
	//b24_ПодразделениеИсполнитель
	пЭлементПоле 				= Элементы.Добавить("b24_ПодразделениеИсполнитель", Тип("ПолеФормы"), Элементы.Группа7);
	пЭлементПоле.Вид 			= ВидПоляФормы.ПолеВвода;
	пЭлементПоле.ПутьКДанным 	= "Объект.b24_ПодразделениеИсполнитель";
	
КонецПроцедуры

&НаСервере
Процедура b24_ПередЗаписьюНаСервереПосле(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если Не Отказ Тогда 
		ТекущийОбъект.ДополнительныеСвойства.Вставить("b24_ЭтоИнтерактивноеИзменение", Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура b24_ОбработкаОповещенияПосле(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "b24_ОбновитьФорму"
		И Параметр = Объект.Ссылка Тогда 
		Прочитать();
		ОбновитьОтображениеДанных();
	КонецЕсли;
	
КонецПроцедуры
