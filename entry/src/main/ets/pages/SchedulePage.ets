import router from '@ohos.router';
import { ScheduleStore } from '../services/ScheduleStore';
import { prompt } from '@kit.ArkUI';

@Entry
@Component
struct SchedulePage {
  @State dateStr: string = '';
  @State songName: string = '';
  @State status: string = '';

  aboutToAppear(): void {
    const params = router.getParams() as Record<string, string>;
    this.dateStr = params?.preselectedDate || ScheduleStore.getSelectedDate() || '';
    this.songName = ScheduleStore.getPendingSongTitle() || '';
  }

  private saveSchedule() {
    if (!this.dateStr) {
      this.status = 'Please pick a date first';
      return;
    }
    if (!this.songName.trim()) {
      this.status = 'Please enter a song name';
      return;
    }
    ScheduleStore.setSelectedDate(this.dateStr);
    ScheduleStore.setPendingSongTitle(this.songName.trim());

    const committed = ScheduleStore.commitSchedule();
    if (committed) {
      this.status = `Saved: ${committed.dateISO} • “${committed.songTitle}”`;
    } else {
      this.status = 'Could not save schedule.';
    }

    // Add a Calendar event here using Calendar Kit
    // await CalendarService.addEvent(committed.dateISO, committed.songTitle)

    // Register a background job/alarms here to play at the date
    // await BackgroundScheduler.schedulePlayback(committed.dateISO, committed.songTitle)
  }

  build() {
    Column({ space: 10 }) {
      Image($r('app.media.arrow_left_circle'))
        .width(28)
        .height(28)
        .fillColor(Color.White)
        .onClick(() => router.back())
        .alignSelf(ItemAlign.Center)
      Text('Schedule Playback')
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .alignSelf(ItemAlign.Center)

      if (this.dateStr) {
        Text(`For date: ${this.dateStr}`)
          .fontSize(10)
          .fontColor(Color.White)
          .alignSelf(ItemAlign.Center)
      } else {
        Text('No date selected yet')
          .fontSize(10)
          .opacity(0.7)
          .fontColor(Color.White)
          .alignSelf(ItemAlign.Center)
      }

      Text('Song name')
        .fontSize(20)
        .opacity(0.7)
        .fontColor(Color.White)
        .alignSelf(ItemAlign.Center)


      TextInput({ placeholder: 'e.g., Love', text: this.songName })
        .onChange(v => this.songName = v)
        .width(160)
        .height(40)
        .alignSelf(ItemAlign.Center)

      Button('Save')
        .width(100)
        .height(30)
        .backgroundColor(Color.Green)
        .borderRadius(22)
        .onClick(() => {
          this.saveSchedule()
          if (this.status) {
            prompt.showToast({ message: this.status })
          }
        })
        .alignSelf(ItemAlign.Center)
        .margin({ bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .padding(10)
    .backgroundColor(Color.Black)
  }
}
