#if defined _butcher_core_included
    #endinput
#endif
#define _butcher_core_included

//Version 1.0.1

/*
	Получение статуса Мясника:
	@param client - Индекс игрока
	return:
	0 - не Мясник
	1 - Мясник
	-1 - в случаи неудачи
*/
native int BUTCHER_GetStstusButcher(int client);

/*
	Вызов события установки статуса Мясника
	@param client - Индекс игрока
*/
native void BUTCHER_TriggerActive(int client);

/*
	Вызов события сброса статуса Мясника
	@param client - Индекс игрока
*/
native void BUTCHER_TriggerReset(int client);

/*
	Узнать количество жизней Мясника
	@param client - Индекс игрока
*/
native int BUTCHER_GetLife(int client);

/*
	Установить количество жизней Мяснику
	@param client - Индекс игрока
*/
native int BUTCHER_SetLife(int client, int number);

/*
	Узнать количество урона Мясника
	@param client - Индекс игрока
	return:
	%f - количество урона Мясника
	-1.0 - в случаи неудачи
*/
native float BUTCHER_GetDamage(int client);

/*
	Установить количество урона Мясника
	@param client - Индекс игрока
	@param2 damage - Количество урона
	
	return:
	1 - в случае успеха
	0 - в случае неудачи
*/
native int BUTCHER_SetDamage(int client, float damage);


//*********************************************//
/*
	Отлов событие старта создания Кобана
	@param client - Индекс игрока
*/
forward void BUTCHER_ActiveStart(int client);

/*
	Отлов события сброса статуса Мясника
	@param client - Индекс игрока
*/
forward void BUTCHER_Reset(int client);

/*
	Событие убийства игрока
	@param client - Индекс игрока
*/
forward void BUTCHER_PlayerDeath(int client, int attacker);

public SharedPlugin __pl_hog = 
{
	name = "butcher",
	file = "butcher",
#if defined REQUIRE_PLUGIN
	required = 1
#else
	required = 0
#endif
};

#if !defined REQUIRE_PLUGIN
public void __pl_butcher_core_SetNTVOptional()
{
	MarkNativeAsOptional("BUTCHER_GetStstusButcher");
	MarkNativeAsOptional("BUTCHER_ActiveStart");
	MarkNativeAsOptional("BUTCHER_TriggerActive");
	MarkNativeAsOptional("BUTCHER_Reset");
	MarkNativeAsOptional("BUTCHER_TriggerReset");
	MarkNativeAsOptional("BUTCHER_PlayerDeath");
	MarkNativeAsOptional("BUTCHER_GetLife");
	MarkNativeAsOptional("BUTCHER_SetLife");
	MarkNativeAsOptional("BUTCHER_GetDamage");
	MarkNativeAsOptional("BUTCHER_SetDamage");
}
#endif