import router from '@ohos.router'
import { Header } from '../components/Header'
@Entry
@Component
struct PageLifePage2 {

  tag: string = 'PageLife2 Page'

  aboutToAppear(){
    console.log(this.tag, 'about to appear')
  }

  onPageShow(){
    console.log(this.tag, 'on page show')
  }

  onBackPress(){
    console.log(this.tag, 'on back press')
  }

  onPageHide(){
    console.log(this.tag, 'on page hide')
  }

  aboutToDisappear(){
    console.log(this.tag, 'about to disappear')
  }

  build() {
    Column({space:50}) {
      Text(this.tag)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)

      Row() {
        Button('PushUrl Page')
          .onClick(() => {
            router.pushUrl({ url: 'pages/PageLifePage' })
          })

        Button('ReplaceUrl Page')
          .onClick(() => {
            router.replaceUrl({ url: 'pages/PageLifePage' })
          })
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')
    }
    .width('100%')
  }
}