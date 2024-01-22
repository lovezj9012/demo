import image from '@ohos.multimedia.image'
import { Header } from '../components/Header'
import notify from '@ohos.notificationManager'
import DownloadCard from '../views/DownloadCard'

@Entry
@Component
struct NotificationPage {
  //全局任务id
  idx: number = 100
  //图像
  pixel: PixelMap

  async aboutToAppear() {
    let rm = getContext(this).resourceManager
    let file = await rm.getMediaContent($r('app.media.watchGT4'))
    image.createImageSource(file).createPixelMap()
      .then(value => this.pixel = value)
      .catch(reason => console.log('testTag', '加载图片异常', JSON.stringify(reason)))
  }

  build() {
    Column({space:20}) {
      Header({title:'通知功能'})
      Button('发送normalText通知')
        .onClick(()=>{
          this.publishNormalTextNotification()
        })

      Button('发送longText通知')
        .onClick(()=>{
          this.publishLongTextNotification()
        })

      Button('发送multiline通知')
        .onClick(()=>{
          this.publishMulitlineNotification()
        })

      Button('发送picture通知')
        .onClick(()=>{
          this.publishPictureNotification()
        })

      DownloadCard()
    }
    .width('100%')
    .height('100%')
    .padding(5)
    .backgroundColor('#f1f2f3')
  }



  publishNormalTextNotification(){
    let request:notify.NotificationRequest={
      id:this.idx++,
      content:{
        contentType:notify.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal:{
          title:'通知标题'+this.idx,
          text:'通知内容详情',
          additionalText:'通知附加内容'
        }
      },
      showDeliveryTime:true, //是否显示通知时间
      deliveryTime:new Date().getTime(),
      groupName:'myapplication',
      slotType:notify.SlotType.SOCIAL_COMMUNICATION
    }
    this.publish(request)
  }

  publishLongTextNotification(){
    let request:notify.NotificationRequest={
      id:this.idx++,
      content: {
        contentType: notify.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
        longText: {
          title: '通知标题' + this.idx,
          text: '通知内容详情',
          additionalText: '通知附加内容',
          longText: '通知中的长文本，我很长，我很长，我很长，我很长，我很长，我很长，我很长',
          briefText: '通知概要和总结',
          expandedTitle: '通知展开时的标题' + this.idx
        }
      }

    }
    this.publish(request)
  }

  publishMulitlineNotification() {
    let request: notify.NotificationRequest = {
      id: this.idx++,
      content: {
        contentType: notify.ContentType.NOTIFICATION_CONTENT_MULTILINE,
        multiLine: {
          title: '通知标题' + this.idx,
          text: '通知内容详情',
          additionalText: '通知附加内容',
          briefText: '通知概要和总结',
          longTitle: '展开时的标题，我很宽，我很宽，我很宽',
          lines: [
            '第一行',
            '第二行',
            '第三行',
            '第四行',
          ]
        }
      }
    }

    this.publish(request)
  }

  publishPictureNotification(){
    let request:notify.NotificationRequest={
      id:this.idx++,
      content: {
        contentType: notify.ContentType.NOTIFICATION_CONTENT_PICTURE,
        picture: {
          title: '通知标题' + this.idx,
          text: '通知内容详情',
          additionalText: '通知附加内容',
          briefText: '通知概要和总结',
          expandedTitle: '展开后标题' + this.idx,
          picture: this.pixel
        }
      }
    }

    this.publish(request)
  }

  private publish(request: notify.NotificationRequest) {
    notify.publish(request)
      .then(() => console.log('Notification', '发送通知成功'))
      .then(reason => console.log('Notification', '发送通知失败', JSON.stringify(reason)))
  }


}