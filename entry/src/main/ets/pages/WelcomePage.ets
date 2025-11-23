@Entry
@Component
struct Index {
  @State picked: string = '';


  aboutToAppear(): void {
    const params =   this.getUIContext().getRouter().getParams() as Record<string, string>;
    this.picked = params?.selectedDate ?? '';
  }

  build() {
    Column({ space: 5 }) {
      Text('Schedule your \nfavorite music')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .padding(10)


      if (this.picked) {
        Text(`Selected Date: ${this.picked}`)
          .fontSize(16)
          .opacity(0.9)
      }

      Button('Open Calendar')
        .width(120)
        .height(30)
        .borderRadius(25)
        .fontSize(10)
        .onClick(() => this.getUIContext().getRouter().pushUrl({ url: 'pages/CalendarPage' }))

      Button('Schedule Playback')
        .width(120)
        .height(30)
        .borderRadius(25)
        .fontSize(10)
        .onClick(() => this.getUIContext().getRouter().pushUrl({ url: 'pages/SchedulePage', params: { preselectedDate: this.picked } }))

      Button('Open Player')
        .width(120)
        .height(30)
        .borderRadius(25)
        .fontSize(10)
        .onClick(() => this.getUIContext().getRouter().pushUrl({ url: 'pages/PlayerPage' }))
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}