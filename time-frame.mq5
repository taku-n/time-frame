input int X = 20;
input int Y = 20;
input int FONT_SIZE = 50;

int OnCalculate(const int RATES_TOTAL,
		const int PREV_CALCULATED,
		const datetime &TIME[],
		const double &OPEN[],
		const double &HIGH[],
		const double &LOW[],
		const double &CLOSE[],
		const long &TICKVOLUME[],
		const long &VOLUME[],
		const int &SPREAD[])
{
	if (PREV_CALCULATED == 0) {
	// "インジケータのロード直後または時間軸を変更した直後" の
	// 最初の OnCalculate() なら
		create_label("TimeFrame", get_time_frame_by_string(Period()));
	}

	return RATES_TOTAL;
}

void OnDeinit(const int REASON)
{
	ObjectDelete(0, "TimeFrame");
}

void create_label(const string NAME, const string TEXT)
{
	ResetLastError();
	if (!ObjectCreate(0, NAME, OBJ_LABEL, 0, 0, 0)) {
		Print("ObjectCreate() failed by ", GetLastError());
	}

	ObjectSetInteger(0, NAME, OBJPROP_XDISTANCE, X);
	ObjectSetInteger(0, NAME, OBJPROP_YDISTANCE, Y);
	ObjectSetString(0, NAME, OBJPROP_TEXT, TEXT);
	ObjectSetInteger(0, NAME, OBJPROP_FONTSIZE, FONT_SIZE);
	ObjectSetInteger(0, NAME, OBJPROP_COLOR, clrWhite);

	ChartRedraw(0);
}

string get_time_frame_by_string(const ENUM_TIMEFRAMES TIME_FRAME)
{
	switch (TIME_FRAME) {
	case PERIOD_M1:
		return "分";
	case PERIOD_M2:
		return "2分";
	case PERIOD_M3:
		return "3分";
	case PERIOD_M4:
		return "4分";
	case PERIOD_M5:
		return "5分";
	case PERIOD_M6:
		return "6分";
	case PERIOD_M10:
		return "10分";
	case PERIOD_M12:
		return "12分";
	case PERIOD_M15:
		return "15分";
	case PERIOD_M20:
		return "20分";
	case PERIOD_M30:
		return "30分";
	case PERIOD_H1:
		return "時間";
	case PERIOD_H2:
		return "2時間";
	case PERIOD_H3:
		return "3時間";
	case PERIOD_H4:
		return "4時間";
	case PERIOD_H6:
		return "6時間";
	case PERIOD_H8:
		return "8時間";
	case PERIOD_H12:
		return "12時間";
	case PERIOD_D1:
		return "日";
	case PERIOD_W1:
		return "週";
	case PERIOD_MN1:
		return "月";
	}

	return "ERROR";
}
