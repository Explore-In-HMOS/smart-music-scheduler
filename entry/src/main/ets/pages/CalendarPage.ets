import { ScheduleStore } from '../services/ScheduleStore';
import prompt from '@ohos.prompt';


@Entry
@Component
struct CalendarPage {
  private static readonly MIN_DATE = new Date(2020, 0, 1);
  private static readonly MAX_DATE = new Date(2030, 11, 31);
  @State selectedDate: Date = new Date();

  aboutToAppear() {
    this.selectedDate = this.clamp(CalendarPage.MIN_DATE, CalendarPage.MAX_DATE, this.selectedDate);
  }

  private clamp(min: Date, max: Date, d: Date): Date {
    if (d.getTime() < min.getTime()) return new Date(min);
    if (d.getTime() > max.getTime()) return new Date(max);
    return d;
  }

  private fmt(d: Date): string {
    const y = d.getFullYear();
    const m = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${y}-${m}-${day}`;
  }

  build() {
    Column({ space: 5 }) {
      Image($r('app.media.arrow_left_circle'))
        .width(28)
        .height(28)
        .fillColor(Color.White)
        .onClick(() =>   this.getUIContext().getRouter().back())
        .alignSelf(ItemAlign.Center)

      Text('Pick a date')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
        .alignSelf(ItemAlign.Center)
        .margin({ bottom: 10 })

      CalendarPicker({
        hintRadius: 10,
        selected: this.selectedDate
      })
        .edgeAlign(CalendarAlign.END)
        .textStyle({ font: { size: 15, weight: FontWeight.Regular } })
        .onChange((value: Date) => {
          this.selectedDate = this.clamp(CalendarPage.MIN_DATE, CalendarPage.MAX_DATE, value);
        })

      Text(`Selected: ${this.selectedDate.toDateString()}`)
        .fontSize(10)
        .opacity(0.9)
        .fontColor(Color.White)
        .margin({ bottom: 20 })
      Button('Use this date')
        .width(120)
        .height(30)
        .borderRadius(22)
        .onClick(() => {
          const iso = this.fmt(this.selectedDate);
          ScheduleStore.setSelectedDate(iso);

          prompt.showToast({ message: 'Date selected' });

          this.getUIContext().getRouter().replaceUrl({
            url: 'pages/Index',
            params: { selectedDate: iso }
          });
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .padding(10)
    .backgroundColor(Color.Black)
  }
}
