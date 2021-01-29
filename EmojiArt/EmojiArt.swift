//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by JJONAMI on 2021/01/25.
//

import Foundation

struct EmojiArt: Codable {
    var backgroudURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Codable, Hashable {
        let text: String
        var x: Int // offset from center
        var y: Int // offset from center
        var size: Int
        let id: Int
        
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int){
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?){
        if json != nil, let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!){
            self = newEmojiArt
        } else {
            return nil
        }
    }
    
    init() { }
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int){
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniqueEmojiId))
    }
}

/**
 1. Acess Control
 open-> public -> internal -> file-private -> private
 
(1) open : 모듈 외부에서도 접근 가능
모든 접근수준 중 open만이 모듈 밖의 다른 모듈에서 상속 가능(class)
모든 접근수준 중 open으로 선언된 class의 멤버(property, method)들만이 다른 모듈에서 override 가능
(2) public : 모듈 외부에서도 접근 가능
모듈 밖에서 생성은 가능 하나 override는 불가능
(3) internal : 하나의 모듈 내부에서만 접근 가능
default
(4) fileprivate : 하나의 파일 내에서만 접근 가능
(5) private : 정의한 블록 내부에서만 접근 가능
 
 => 바깥의 접근제어 수준보다 높은 수준의 내부 요소는 있을 수 없다
 
 ===================================
 
 2. Propeerty Wrappers
 @Something
 
 computed property의 getter/setter를 기본으로 가진 struct
 
 @Published
 @Stat
 @ObservedObjec
 @Binding
 @Environment
 
 ex)    @Published var emojiArt: EmojiArt = EmojiArt()
     ->
     struct Published {
        var wrappedValue: EmojiArt
        var projectedValue: Publisher<EmojiArt, Never> // 주기적으로 값을 내보내는 게시자
     }
     
     var _emojiArt: Published = Published(wrappedValue: EmojiArt())
     var emojiArt: EmojiArt {
        get { _emojiArt.wrappedValue }
        set { _emojiArt.wrappedValue = newValue }
     }
 
 projectedValue -> using [ $emojiArt ]
 
 > Binding
 :  Binding provides us a reference like access to a value type. can read and write a value owned by a source of truth
 
 ===================================

 3. Publisher
 It is an object that emits values and possibly a failure object if it fails while dogin so.
 
 Publisher<Output, Failure>
 Oupput : type of the thing this Publisher publishes.
 Failure : type of the thins it communicates if it fails while trying to publish.
 
 */
