export interface MusicSchedule {
  dateISO: string;
  songTitle: string;
}

class _ScheduleStore {
  private _selectedDateISO: string = '';
  private _pendingSongTitle: string = '';
  private _latestSchedule: MusicSchedule | null = null;

  setSelectedDate(iso: string) {
    this._selectedDateISO = iso;
  }
  getSelectedDate(): string { return this._selectedDateISO; }

  setPendingSongTitle(title: string) {
    this._pendingSongTitle = title;
  }
  getPendingSongTitle(): string { return this._pendingSongTitle; }

  commitSchedule(): MusicSchedule | null {
    if (!this._selectedDateISO || !this._pendingSongTitle) return null;
    this._latestSchedule = {
      dateISO: this._selectedDateISO,
      songTitle: this._pendingSongTitle
    };
    return this._latestSchedule;
  }

  getLatestSchedule(): MusicSchedule | null {
    return this._latestSchedule;
  }
}

export const ScheduleStore = new _ScheduleStore();
