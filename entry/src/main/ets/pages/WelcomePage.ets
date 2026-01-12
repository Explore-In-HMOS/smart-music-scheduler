import { CalendarPage } from './CalendarPage';
import { PlayerPage } from './PlayerPage';
import { SchedulePage } from './SchedulePage';

interface ScheduleParams {
  preselectedDate: string;
}

@Entry
@Component
struct Index {
  pathStack: NavPathStack = new NavPathStack();
  @State picked: string = '';


  @Builder
  PageMap(name: string) {
    if(name === 'CalendarPage'){
      calendarPageBuilder()
    } else if(name === 'SchedulePage'){
      schedulePageBuilder()
    } else if(name === 'PlayerPage'){
      playerPageBuilder()
    }
  }

  build() {
    Navigation(this.pathStack) {
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
          .onClick(() => {
            this.pathStack.pushPathByName('CalendarPage', null, (popInfo: PopInfo) => {
              const result = popInfo.result as Record<string, string>;
              if(result?.selectedDate) {
                this.picked = result.selectedDate;
              }
            });
          })

        Button('Schedule Playback')
          .width(120)
          .height(30)
          .borderRadius(25)
          .fontSize(10)
          .onClick(() => {
            const params: ScheduleParams = { preselectedDate: this.picked };
            this.pathStack.pushPathByName('SchedulePage', params);
          })

        Button('Open Player')
          .width(120)
          .height(30)
          .borderRadius(25)
          .fontSize(10)
          .onClick(() => {
            this.pathStack.pushPathByName('PlayerPage', null);
          })
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
    .navDestination(this.PageMap)
  }
}

@Builder
function calendarPageBuilder() {
  CalendarPage()
}

@Builder
function schedulePageBuilder() {
  SchedulePage()
}

@Builder
function playerPageBuilder() {
  PlayerPage()
}