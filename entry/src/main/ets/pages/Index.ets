import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State inputText: string = '';
  @StorageLink("testProp") testProp: string = '';

  build() {
    Column() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })

      Button() {
        Text('通过@StorageLink("testProp")读取数据')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .onClick(() => {
            this.message = '@StorageLink("testProp")：' + this.testProp;
          })
      }
      Button() {
        Text('通过@AppStorage("testProp")数据')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .onClick(() => {
            this.message = '@AppStorage("testProp")：' + AppStorage.get('testProp');
          })
      }
      Button() {
        Text('清空testProp数据')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .onClick(() => {

            // 以下两种方法都不能清空AppStorage，因为使用了@StorageLink
            // AppStorage.clear();
            // AppStorage.delete('testProp');

            // 如果使用了@StorageLink，则可以手动清空（和初始化的一致即可）
            this.testProp = '';
            this.message = '已清空AppStorage';
          })
      }

      TextInput({placeholder: '请输入数据'})
        .onChange((text) => {
          this.inputText = text;
        })
        .margin({ top: 20 })
        .width('100%')
        .height(50)
        .backgroundColor(Color.White)
        .borderRadius(5)
        .padding({ left: 10, right: 10 })

      Button() {
        Text('通过@StorageLink("testProp")保存数据')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .onClick(() => {
            this.testProp = this.inputText;
            promptAction.showToast({
              message: '保存成功',
              duration: 2000
            });
          })
      }

      Button() {
        Text('通过AppStorage("testProp").set保存数据')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .onClick(() => {
            AppStorage.set('testProp', this.inputText);
            promptAction.showToast({
              message: '保存成功',
              duration: 2000
            });
          })
      }
    }
    .height('100%')
    .width('100%')



  }
}