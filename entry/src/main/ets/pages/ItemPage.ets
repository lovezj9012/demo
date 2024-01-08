
class Item {
  name: string
  image: ResourceStr
  price: number
  discount: number

  constructor(name: string, image: ResourceStr, price: number,discount:number=0) {
    this.name = name
    this.image = image
    this.price = price
    this.discount=discount
  }
}

/**
 * struct 在ArkTs中表示自定义组件:可复用的UI单元
 * 装饰器：用来装饰类结构、方法、变量，例如(@Entry、@Component、@State)
 * @Entry 标记当前组件是入口组件
 * @Component 标记自定义组件
 * @State 标记该变量是状态变量，值变化是会触发UI刷新
 */

import {Header} from '../components/Header'

//全局公共样式函数
@Styles function itemCardBody(){
  .width('95%')
  .backgroundColor('#C0C0C0')
  .borderRadius(20)
  .height(170)
  .padding(10)
}

@Extend(Text) function priceText(){
  .fontSize(18)
  .fontColor('#F36')
}
//全局自定义构建函数
@Builder function ItemCard(item:Item){
  if (item.discount) {
    Row({ space: 10 }) {
      Image(item.image)
        .width(150)
      Column({ space: 5 }) {
        Text(item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Text('原价：￥' + item.price)
          .fontSize(14)
          .fontColor('#ccc')
          .decoration({ type: TextDecorationType.LineThrough })

        Text('价格：￥' + (item.price - item.discount))
          .priceText()
        Text('折扣：￥' + item.discount)
          .priceText()
      }
      .margin({ left: 10 })
      .alignItems(HorizontalAlign.Start)
    }
    .itemCardBody()

  } else {
    Row({ space: 10 }) {
      Image(item.image)
        .width(150)
      Column({ space: 5 }) {
        Text(item.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Text('价格：￥' + item.price)
          .priceText()
      }
      .margin({ left: 10 })
      .alignItems(HorizontalAlign.Start)
    }
    .itemCardBody()
  }
}

@Entry
@Component
struct ItemPage{

  private products:Array<Item>  =[
    new Item('Mate 60',$r('app.media.mate60'),6399,500),
    new Item('MateBook',$r('app.media.mateBookProX'),8999),
    new Item('Watch GT4',$r('app.media.watchGT4'),2999),
    new Item('FreeBuds Pro',$r('app.media.freeBudsPro3'),599),
    new Item('Mate X5',$r('app.media.mateX5'),10999)
  ]

  build(){   //build UI描述：其内部以声明式方式描述UI结构
    Column({space:8}){
      /*Row(){
        Text('商品列表')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .margin({bottom:20})

      ForEach(this.products,(item:Item)=>{
          if(item.discount){
            Row({space:10}){
              Image(item.image)
                .width(150)
              Column({space:5}){
                Text(item.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                Text('原价：￥'+item.price)
                  .fontSize(14)
                  .fontColor('#ccc')
                  .decoration({type:TextDecorationType.LineThrough})

                Text('价格：￥'+(item.price-item.discount))
                  .fontSize(18)
                  .fontColor('#F36')
                Text('折扣：￥'+item.discount)
                  .fontSize(18)
                  .fontColor('#F36')
              }
              .margin({left:10})
              .alignItems(HorizontalAlign.Start)
            }
            .width('95%')
            .backgroundColor('#C0C0C0')
            .borderRadius(20)
            .height(170)
            .padding(10)

          }else{
            Row({space:10}){
              Image(item.image)
                .width(150)
              Column({space:5}){
                Text(item.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                Text('价格：￥'+item.price)
                  .fontSize(18)
                  .fontColor('#F36')
              }
              .margin({left:10})
              .alignItems(HorizontalAlign.Start)
            }
            .width('95%')
          .backgroundColor('#C0C0C0')
          .borderRadius(20)
          .height(170)
          .padding(10)
        }

      })*/

      /**
       * List组件是容器，ListItem不是容器
       * ListItem中只能有一个根组件
       * layoutWeight:布局的时，当一个组件固定告诉，将layoutWeight
       * 设置为1时，表示其余高度都分配给另一个组件
       */

      Header({title:'商品列表'})
        .margin({bottom:20})
      /*Row(){
        Text('商品列表')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(30)
      .margin({bottom:20})*/

      List({space:10}){
        ForEach(this.products, (item: Item) => {
          ListItem() {
            ItemCard(item)
          }
          .width('100%')
          .layoutWeight(1)


        })

      }




    }
    .height('100%')
  }
}