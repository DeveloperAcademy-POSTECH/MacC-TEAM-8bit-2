//
//  GymSettingModel.swift
//  OrrRock
//
//  Created by Ruyha on 2022/11/03.
//  설정 -> 앱의 사진 권한 설정 이동 알림창 문구 열거형입니다.

import Foundation

enum AuthSettingAlert: String {
    //모두 거절했을때
    case denied = "\"오르락\"은 사진 앨범 접근 권한이 없이는 사용이 어렵습니다.\r\n클라이밍 비디오 등록 및 분류를 하기 위해 사진 앨범 접근 권한이 필요합니다.\r\n권한 허용을 위해 설정 화면으로 이동하시겠습니까?"

    //부분 허용후 권한 밖의 알림선택 했을때
    case limited = "\'접근 허용된 사진\' 이외의 사진이 선택 되었습니다.\r\n앱의 원할한 사용을 위해 설정에서\n\'모든 사진\'허용 혹은\r\n\'선택한 사진\'을 추가해야 합니다.\r\n권한 설정을 위해 설정 화면으로 이동하시겠습니까?"
}
