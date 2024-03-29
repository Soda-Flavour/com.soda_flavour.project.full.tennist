const db = require('../../../db');

const tableNames = require('../../../constants/tableNames');

module.exports = {
  async getRacketHistoryDetailData(reqParams) {
    // reqParams.userRacketHistoryId   t_user_id

    const racketHistoryData = await db
      .select(
        'urh.weight_tune',
        'urh.replacement_grip_type',
        'urh.overgrip_num',
        'urh.racket_balance_type',
        'urh.racket_balance_val',
        'urh.main_gut_lb_tension',
        'urh.cross_gut_lb_tension', {
          racket_model: 'ra.model',
          gut_company_name: 'gutc.name',
          gut_name: 'gut.name',
        }
      )
      .from({
        urh: tableNames.userRacketHistory
      })
      .innerJoin({
          ur: tableNames.userRacket
        },
        'ur.id',
        '=',
        'urh.t_user_racket_id'
      )
      .innerJoin({
        ra: tableNames.racketData
      }, 'ra.id', '=', 'ur.t_racket_id')

      .innerJoin({
        gut: tableNames.gut
      }, 'gut.id', '=', 'urh.t_gut_id')
      .innerJoin({
          gutc: tableNames.gutCompany
        },
        'gutc.id',
        '=',
        'gut.t_gut_company_id'
      )
      .where({

        'urh.id': reqParams.userRacketHistoryId,
      })
      .first();


    const commentListData = await db
      .select('tu.nick', 'tu.thumb', 'urhc.comment', {
        updated_date: 'urhc.updated_at',
      })
      .from({
        urhc: tableNames.userRacketHistorycoment
      })
      .innerJoin({
        tu: tableNames.user
      }, 'tu.id', '=', 'urhc.t_user_id')
      .where({
        'urhc.t_user_racket_history_id': reqParams.userRacketHistoryId,
      })
      .orderBy('urhc.updated_at', 'desc');

    return {
      racket_data: racketHistoryData,
      list: commentListData
    };
  },

  async insertRacketHistory(userRacketHistoryData) {
    return db(tableNames.userRacketHistory).insert(userRacketHistoryData);
  },

  async insertRacketHistoryDetailComment(reqParams) {
    const insertId = await db(tableNames.userRacketHistorycoment).insert(
      reqParams
    );

    const result = await db
      .select('urhc.comment', 'urhc.updated_at', {
        nick: 'tu.nick'
      })
      .from({
        urhc: tableNames.userRacketHistorycoment
      })
      .innerJoin({
        tu: tableNames.user
      }, 'tu.id', '=', 'urhc.t_user_id')
      .where({
        'urhc.id': insertId
      })
      .first();
    return result;
  },

  async getUserRacketHistoryData(reqParams) {
    const racketHistoryData = await db
      .select(
        'urh.id',
        'urh.t_user_racket_id',
        'urh.weight_tune',
        'urh.replacement_grip_type',
        'urh.overgrip_num',
        'urh.racket_balance_type',
        'urh.racket_balance_val',
        'urh.main_gut_lb_tension',
        'urh.cross_gut_lb_tension', {
          gut_company_name: 'gutc.name',
          gut_name: 'gut.name',
          updated_date: 'urh.updated_at',
        }
      )
      .from({
        urh: tableNames.userRacketHistory
      })
      .innerJoin({
        gut: tableNames.gut
      }, 'gut.id', '=', 'urh.t_gut_id')
      .innerJoin({
          gutc: tableNames.gutCompany
        },
        'gutc.id',
        '=',
        'gut.t_gut_company_id'
      )
      .where({

        'urh.t_user_racket_id': reqParams.userRacketId,
      });

    console.log('racketHistoryData', racketHistoryData);

    const RacketInfoData = await db
      .select({
        racket_nickname: 'ru.racket_nickname',
        company_name: 'rc.name',
        model: 'tr.model',
        weight_ungut: 'tr.weight_strung',
        racket_balance_lb_val: 'tr.balance_pt',
        racket_balance_lb_type: 'tr.balance_type',
        main_pattern: 'tr.pattern_main',
        cross_pattern: 'tr.pattern_cross',
      })
      .from({
        ru: tableNames.userRacket
      })
      .innerJoin({
        tr: tableNames.racketData
      }, 'tr.id', '=', 'ru.t_racket_id')
      .innerJoin({
          rc: tableNames.racketCompany
        },
        'rc.id',
        '=',
        'tr.t_racket_company_id'
      )
      .where({
        'ru.id': reqParams.userRacketId,
      })
      .first();

    return {
      list: racketHistoryData,
      racket_info: RacketInfoData
    };
  },

  // async get(userId) {
  //   return db
  //     .select(
  //       'tup.ntrp',
  //       {
  //         playstyle: 'tup.t_play_style_id',
  //         forehand: 'tup.t_forehand_style_id',
  //         backhand: 'tup.t_backhand_style_id',
  //       }
  //       // tup.t_forehand_style_id
  //     )
  //     .from({ tup: tableNames.userPhysical })
  //     .leftJoin(
  //       { tbs: tableNames.backhandStyle },
  //       'tup.t_backhand_style_id',
  //       '=',
  //       'tbs.id'
  //     )
  //     .leftJoin(
  //       { tfs: tableNames.forehandStyle },
  //       'tup.t_forehand_style_id',
  //       '=',
  //       'tfs.id'
  //     )
  //     .leftJoin(
  //       { tps: tableNames.playStyle },
  //       'tup.t_forehand_style_id',
  //       '=',
  //       'tps.id'
  //     )
  //     .where('tup.t_user_id', userId);
  // },
  // async update(physicalData, userId) {
  //   return db(tableNames.userPhysical)
  //     .where('t_user_id', userId)
  //     .update(physicalData);
  // },
};