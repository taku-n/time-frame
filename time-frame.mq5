input int X = 20;
input int Y = 20;
input int FONT_SIZE = 20;

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
	Print("PREV_CALCULATED => ", PREV_CALCULATED);

	static ENUM_TIMEFRAMES time_frame = Period();

	if (PREV_CALCULATED == 0) {
	// 時間軸を変更したあとの最初の OnCalculate() なら
		Print("create_text() in first OnCalculate()");
		create_text("TimeFrame", get_time_frame_by_string(Period()));
	}

	if (time_frame != Period()) {
		Print("create_text()");
		create_text("TimeFrame", get_time_frame_by_string(Period()));
	}

	ObjectSetInteger(0, "TimeFrame", OBJPROP_XDISTANCE, 0);

	return RATES_TOTAL;
}

void create_text(const string NAME, const string TEXT)
{
	int nwin;
	datetime time;
	double price;

	if (ObjectFind(0, NAME) == 0) {
		Print("ObjectDelete()");
		ObjectDelete(0, NAME);
	}

	ResetLastError();
	if (!ChartXYToTimePrice(0, X, Y, nwin, time, price)) {
		Print("ChartXYToTimePrice() failed by ", GetLastError());
	}

	ResetLastError();
	if (!ObjectCreate(0, NAME, OBJ_TEXT, nwin, time, price)) {
		Print("ObjectCreate() failed by ", GetLastError());
	}

	ObjectSetString(0, NAME, OBJPROP_TEXT, TEXT);
	ObjectSetInteger(0, NAME, OBJPROP_FONTSIZE, FONT_SIZE);
	ObjectSetInteger(0, NAME, OBJPROP_COLOR, clrWhite);

	ChartRedraw(0);
}

string get_time_frame_by_string(const ENUM_TIMEFRAMES TIME_FRAME)
{
	switch (TIME_FRAME) {
	case PERIOD_M1:
		return "分足";
	case PERIOD_M2:
		return "2分足";
	case PERIOD_M3:
		return "3分足";
	case PERIOD_M4:
		return "4分足";
	case PERIOD_M5:
		return "5分足";
	case PERIOD_M6:
		return "6分足";
	case PERIOD_M10:
		return "10分足";
	case PERIOD_M12:
		return "12分足";
	case PERIOD_M15:
		return "15分足";
	case PERIOD_M20:
		return "20分足";
	case PERIOD_M30:
		return "30分足";
	case PERIOD_H1:
		return "時間足";
	case PERIOD_H2:
		return "2時間足";
	case PERIOD_H3:
		return "3時間足";
	case PERIOD_H4:
		return "4時間足";
	case PERIOD_H6:
		return "6時間足";
	case PERIOD_H8:
		return "8時間足";
	case PERIOD_H12:
		return "12時間足";
	case PERIOD_D1:
		return "日足";
	case PERIOD_W1:
		return "週足";
	case PERIOD_MN1:
		return "月足";
	}

	return "ERROR";
}
