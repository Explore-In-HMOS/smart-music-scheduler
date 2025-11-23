import { ScheduleStore } from '../services/ScheduleStore';


class AudioFacade {
  async playSong(title: string): Promise<void> {
    // TODO: title -> dosya/URL eşle ve Audio Kit ile çal
    await Promise.resolve();
  }
  async stop(): Promise<void> {
    // TODO: Audio Kit stop çağrısı
    await Promise.resolve();
  }
}
const audio = new AudioFacade();

@Entry
@Component
struct PlayerPage {
  @State note: string = '';
  @State songTitle: string = '';
  @State isPlaying: boolean = false;

  aboutToAppear(): void {
    const latest = ScheduleStore.getLatestSchedule();
    this.songTitle = latest?.songTitle || ScheduleStore.getPendingSongTitle() || '';
  }

  async playNow() {
    if (!this.songTitle) {
      this.note = 'No saved song. Go to “Schedule Playback” and save one.';
      this.isPlaying = false;
      return;
    }
    try {
      await audio.playSong(this.songTitle);
      this.note = `Playing: “${this.songTitle}”`;
      this.isPlaying = true;
    } catch (e) {
      this.note = 'Audio playback not wired yet.';
      this.isPlaying = false;
    }
  }

  async stopNow() {
    try {
      await audio.stop();
      this.isPlaying = false;
      this.note = 'Stopped.';
    } catch (e) {
      this.note = 'Stop not wired yet.';
    }
  }

  build() {
    Column({ space: 10 }) {
      Image($r('app.media.arrow_left_circle'))
        .width(28)
        .height(28)
        .fillColor(Color.White)
        .onClick(() => this.getUIContext().getRouter().back())
        .alignSelf(ItemAlign.Center)

      Text('Player')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .alignSelf(ItemAlign.Center)

      if (this.songTitle && this.isPlaying) {
        Image($r('app.media.music_fill'))
          .width(30)
          .height(30)
          .fillColor(Color.White)
          .alignSelf(ItemAlign.Center)
      }

      if (this.songTitle) {
        Text(`Saved song: “${this.songTitle}”`)
          .fontSize(14)
          .opacity(0.9)
          .fontColor(Color.White)
          .alignSelf(ItemAlign.Center)
      } else {
        Text('No saved song yet')
          .fontSize(12)
          .opacity(0.6)
          .fontColor(Color.White)
          .alignSelf(ItemAlign.Center)
      }

      Row({ space: 10 }) {
        Column({ space: 4 }) {
          Image($r('app.media.play_fill'))
            .width(30)
            .height(30)
            .fillColor(Color.Green)
            .onClick(() => this.playNow())
            .alignSelf(ItemAlign.Center)
          Text('Start')
            .fontSize(12)
            .fontColor(Color.White)
            .alignSelf(ItemAlign.Center)
        }

        Column({ space: 4 }) {
          Image($r('app.media.pause'))
            .width(30)
            .height(30)
            .fillColor(Color.Red)
            .onClick(() => this.stopNow())
            .alignSelf(ItemAlign.Center)
          Text('Stop')
            .fontSize(12)
            .fontColor(Color.White)
            .alignSelf(ItemAlign.Center)
        }
      }
      .alignSelf(ItemAlign.Center)

      if (this.note) {
        Text(this.note)
          .fontSize(12)
          .opacity(0.85)
          .fontColor(Color.White)
          .alignSelf(ItemAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .padding(5)
    .backgroundColor(Color.Black)
  }
}
