#pragma semicolon 1
#pragma newdecls required

#include <butcher_core>

ConVar
	cvScreen,
	cvColorsOn,
	cvColorsOff,
	cvDuration;

public Plugin myinfo =
{
	name = "[Butcher Core] Screen Transformation",
	author = "Nek.'a 2x2 | ggwp.site ",
	description = "Цветной экран при превращении",
	version = "1.0.1",
	url = "https://ggwp.site/"
};

public void OnPluginStart()
{
	cvScreen = CreateConVar("sm_butcher_screen_enable", "1", "Включить плагин");

	cvColorsOn = CreateConVar("sm_butcher_screen_colorson", "204 204 0 0 0 102", "Цвет активации режима");

	cvColorsOff = CreateConVar("sm_butcher_screen_colorsoff", "255 255 255 255 255 255", "Цвет отключения режима");

	cvDuration  = CreateConVar("sm_butcher_screen_force", "2000", "Насыщеность");

	AutoExecConfig(true, "screen", "butcher");
}

public void BUTCHER_ActiveStart(int client)
{
	if(!cvScreen.BoolValue)
		return;

	char sColors[32];
	cvColorsOn.GetString(sColors, sizeof(sColors));
	FuncColors(client, sColors);
}

public void BUTCHER_Reset(int client)
{
	if(!cvScreen.BoolValue)
		return;

	char sColors[32];
	cvColorsOff.GetString(sColors, sizeof(sColors));
	FuncColors(client, sColors);
}

void FuncColors(int client, char colors[32])
{
	char sPartColor[6][32];
	int iColors[6];

	ExplodeString(colors, " ", sPartColor, 6, 4);

	for(int i = 0; i < 6; i++)
	{
		TrimString(sPartColor[i]);
		iColors[i] = StringToInt(sPartColor[i]);
	}
	
	int clr[4];
	clr[3] = 255;
	clr[0] = GetRandomInt(iColors[0], iColors[1]);
	clr[1] = GetRandomInt(iColors[2], iColors[3]);
	clr[2] = GetRandomInt(iColors[4], iColors[5]);
	PerformFade(client, cvDuration.IntValue, clr);
}

void PerformFade(int client, int duration, int color[4]) 
{
	if(IsValidClient(client) && !IsPlayerAlive(client))
		return;

	Handle hFadeClient = StartMessageOne("Fade", client);
	BfWriteShort(hFadeClient, duration);
	BfWriteShort(hFadeClient, 0);
	BfWriteShort(hFadeClient, (0x0001));
	BfWriteByte(hFadeClient, color[0]);
	BfWriteByte(hFadeClient, color[1]);
	BfWriteByte(hFadeClient, color[2]);
	BfWriteByte(hFadeClient, color[3]);
	EndMessage();
}

stock bool IsValidClient(int client)
{
	return 0 < client <= MaxClients && IsClientInGame(client);
}