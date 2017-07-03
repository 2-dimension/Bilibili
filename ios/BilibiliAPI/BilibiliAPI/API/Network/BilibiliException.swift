//
//  BilibiliException.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/30.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation


struct BilibiliException: OptionSet
{
    let rawValue: Int
    
    /* BASIC */
    
    static let OK = 0         //Request succeeded.
    static let FAIL = -1      //Request failed.
    
    static let ACCESS_DENIED = -403
    static let ACCESS_KEY_INVALID = -2
    static let ACCESS_TOKEN_EXPIRED = -658
    static let ACCOUNT_IS_BANNDED = -102
    static let ACCOUNT_IS_NOT_LOGIN = -101
    static let ACTIVE_COUNT_TRIGGLE_LIMITS = -624
    static let ACTIVITY_GIFT_LACKED = -612
    static let ADMIN_APPLY_DUMPLICATE = -801
    static let ADMIN_APPLY_NOT_EXIST = -800
    static let ADMIN_CAN_NOT_QUIT_COMMUNITY = -712
    static let ADMIN_POSITION_IS_FULL = -605
    static let AGREEMENT_DISAGREEMENT_THE_FEEDBACK_AGAINS = -614
    static let ALL_CODE_HAS_BEEN_SENT = -631
    static let API_SIGN_INVALID = -3
    static let APPLICATION_NOT_EXISTS_OR_IS_BANDED = -1
    static let BEGIN_DATE_FORMAT_ERROR = -601
    static let BEGIN_DATE_TO_END_DATE_SELECT_TOO_LARGE = -603
    static let CAPTCHA_EXPIRED = -650
    static let CAPTCHA_IS_NOT_MATCH = -105
    static let CAPTCHA_SEND_FAILED = -648
    static let CARD_IS_GIVEN_AWAY = -203
    static let CD_TIME_CAN_NOT_REPORT_IT = 12019
    static let CD_TIME_NOT_TO_COMMENT = 12014
    static let COINS_IS_NOT_ENOUGH = -104
    static let COINS_NOT_ENOUGH = -655
    static let COMMENT_NEED_TO_REVIEW = 12017
    static let COMMENT_ON_CONTENT_FILTERING_TO_SENSITIVE_WORDS = 12016
    static let COMMUNITY_IN_PRISON = -105
    static let COMMUNITY_IS_BANNED = -102
    static let COMMUNITY_IS_EXISTS = -604
    static let COMMUNITY_MEMBERS_IS_FULL = -608
    static let COMMUNITY_NOT_ACTIVATE = -103
    static let COMMUNITY_NOT_ALLOW_JOIN = -606
    static let COMMUNITY_NOT_ALLOW_TALK = -104
    static let COMMUNITY_NOT_EXISTS = -603
    static let COMMUNITY_NOT_LOGIN = -101
    static let COMMUNITY_NOT_OFFICIAL = -107
    static let COMMUNITY_ONLY_FORMAL_CAN_JOIN = -607
    static let CONTENT_HAVE_CONTAIN_UNALLOW_KEYWORDS = -1008
    static let CONTENT_IS_TOO_LONG = -1010
    static let CREDITS_IS_NOT_ENOUGH = -103
    static let CURRENT_STATE_CANNOT_PERFORM_THE_USER_ACTION = 12018
    static let DAYS_SELECT_TOO_LARGE = -605
    static let DELETE_POST_COUNT_OVER_LIMIT = -721
    static let DOCUMENT_IS_NOT_EXISTS = -404
    static let EMAIL_EXISTS = -622
    static let EMAIL_FORMAT_ERROR = -621
    static let END_DATE_FORMAT_ERROR = -602
    static let EXISTING_REVIEW_TOPICS = 12001
    static let FAVORITE_LIST_IS_FULL = -1
    static let FAVORITE_EXIST = 11007
    static let FAVORITE_NOT_EXIST = 11013
    static let FILENAME_IS_NOT_EXISTS = -1003
    static let FILESIZE_RROR = -1005
    static let FILE_UPLOAD_IS_NOT_A_VALID_IMAGE = -616
    static let FILE_UPLOAD_OVERSIZED = -617
    static let FONTSIZE_INVALID = -1006
    static let FORBIDDEN_TO_REPORT = 12005
    static let FORBID_USER_COUNT_OVER_LIMIT = -720
    static let GAME_NOT_ACTIVEABLE = -623
    static let HAS_BEEN_DELETED = 12022
    static let HAS_BEEN_OPERATING = 12007
    static let HAVE_TO_REPORT = 12008
    static let HIDE_SHOW_THE_FEEDBACK_FAILED = -615
    static let ILLEGAL_FATHER_COMMENTS = 12010
    static let ILLEGAL_PARAMETER = 12009
    static let ILLEGAL_TO_REPORT = 12012
    static let ILLEGAL__PRAISE = 12011
    static let IMAGE_NOT_EXISTS = -690
    static let IMAGE_TYPE_UNRIGHT = -950
    static let IMAGE_UPLOAD_FAILED = -951
    static let INDEX_IS_EXISTS = -1002
    static let INDEX_IS_NOT_EXISTS_ON_DB = -1001
    static let INFORM_PEOPLE_TOO_MUCH = 12013
    static let IN_A_SHORT_PERIOD_OF_TIME_CAN_NOT_REPEAT_COMMENT = 12023
    static let IN_MAINTENANCE = -444
    static let LIVE_ROOM_LOCKED = -613
    static let LIVE_ROOM_NOT_EXIST = -404
    static let LIVE_SILVER_RECEIVE_CONDITION_NOT_MATCH = -99
    static let LIVE_SILVER_RECEIVE_FINISHED = -10017
    static let LOTTERY_IS_END = -202
    static let LOTTERY_IS_ENDED = -630
    static let LOTTERY_IS_NOT_START = -629
    static let LOTTERY_IS_NOT_STARTED = -201
    static let MD5_ERROR = -1004
    static let MODE_INVALID = -1007
    static let MODIFY_PERSON_INFO_INVALID = -653
    static let MODIFY_PERSON_SIGNATURE_PARAM_INVALID = -1001
    static let NICKNAME_UPDATE_LOCKED = -707
    static let NO_PERMISSION_FOR_MANAGE = -612
    static let OBTAIN_USER_INFO_FAILED = -750
    static let ORDER_METHOD_ERROR = -606
    static let OVERFLOW_FOR_POOL = -613
    static let OVERSPEED = -503
    static let OVER_MAX_FAVORITES_COUNT = -607
    static let PACKAGE_LACKED = -612
    static let PASSWORD_ERROR = -627
    static let PASSWORD_IS_LEAKED = -628
    static let PASSWORD_RETRIED_TOO_MANY_TIMES = -625
    static let PHONE_NUM_CONFLICT_WIDTH_USERNAME = -652
    static let PHONE_NUM_EXISTS = -647
    static let PHONE_NUM_FORMAT_INVALID = -649
    static let PHONE_NUM_IS_BOUND = -651
    static let PHONE_NUM_IS_INVALID = -646
    static let PINYIN_IS_NOT_INPUT = -604
    static let PLAYTIME_ERROR = -1011
    static let POST_HAVE_COLLECTED = -651
    static let POST_NOT_EXISTS = -650
    static let POST_REPLAY_COUNT_OVER_LIMIT_CAN_NOT_DELETE = -722
    static let PROHIBIT_COMMENTS = 12002
    static let PROHIBIT_OPERATION = 12004
    static let PROHIBIT_TO_REPLY = 12003
    static let QRCODE_NOENTITY_OR_EXPIRED = -800
    static let REPLY_NOT_EXISTS = -680
    static let REPORT_DOES_NOT_EXIST = 12020
    static let REQUEST_ERROR = -400
    static let SEARCH_SESSION_IS_EXISTS = -502
    static let SERVER_INTERNAL_ERROR = -500
    static let SMS_CODE_NOT_RIGHT = -900
    static let SMS_CODE_TOO_FREQUENTLY = -901
    static let SYSTEM_ACCOUNTS_CAN_NOT_ATTENTION = -609
    static let SYSTEM_ERROR = -501
    static let THE_REPORT_HAS_BEEN_PROCESSING = 12021
    static let TOPIC_NOT_EXIST = -1112
    static let UANME_OR_PASSWORD_TOO_SHORT = -645
    static let USERNAME_EXISTS = -620
    static let USERNAME_FORMAT_ERROR = -618
    static let USERNAME_TOO_LONG = -619
    static let USER_ALREADY_IS_ADMIN = -708
    static let USER_APPLY_COUNT_OVER_LIMIT = -705
    static let USER_APPLY_NOT_ACHIEVED_DEMAND = -710
    static let USER_CAN_NOT_APPLY_LOW_LEVEL_POSITION = -709
    static let USER_HAS_NO_PERMISSION = -704
    static let USER_HAVE_BEEN_FORBIDDEN = -703
    static let USER_HAVE_JOIN_COMMUNITY = -701
    static let USER_HAVE_SUPPORTED = -707
    static let USER_IS_NOT_EXISTS = -626
    static let USER_IS_REPLYING_ADMIN_CAN_NOT_QUIT_COMMUNITY = -711
    static let USER_NOT_BIND_PHONE = -706
    static let USER_NOT_IN_COMMUNITY = -702
    static let VERIFICATION_CODE_ERROR_NOT_TO_COMMENT = 12015
    static let VIDEO_IS_REPEAT = -307
    static let VIDEO_NOT_EXIST = -1111
    static let WITHOUT_THE_COMMENT = 12006
    static let YOU_CAN_NOT_ADD_MYSELF_TO_ATTENTIONS = -608
    static let YOU_HAVE_ATTENTION_TOO_MANY_USERS = -611
    static let YOU_HAVE_BANNED_BY_USER = -610
    static let YOU_HAVE_BEEN_BANNED = -1009
}
