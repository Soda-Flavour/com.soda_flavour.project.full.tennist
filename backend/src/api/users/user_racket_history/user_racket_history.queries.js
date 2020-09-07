const db = require('../../../db');

const tableNames = require('../../../constants/tableNames');

const fields = [];

module.exports = {
  async getRacketList(userId) {
    return db
      .select(
        'ru.id',
        'ru.racket_nickname',
        'ru.seq',
        'tr.model',
        'rv.name_kor'
      )
      .from({ ru: tableNames.userRacket })
      .innerJoin({ tr: tableNames.racket }, 'tr.id', '=', 'ru.t_racket_id')
      .innerJoin(
        { rv: tableNames.racketVersion },
        'rv.id',
        '=',
        'tr.t_racket_version_id'
      )
      .where({ 'ru.t_user_id': userId });
  },

  async insertRacketHistory(userRacketHistoryData) {
    return db(tableNames.userRacketHistory).insert(userRacketHistoryData);
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
        'urh.cross_gut_lb_tension'
      )
      .from({ urh: tableNames.userRacketHistory })
      .innerJoin({ gut: tableNames.gut }, 'gut.id', '=', 'urh.t_gut_id')
      .innerJoin(
        { gutc: tableNames.gutCompany },
        'gutc.id',
        '=',
        'gut.t_gut_company_id'
      )
      .where({
        'urh.t_user_id': reqParams.id,
        'urh.t_user_racket_id': reqParams.userRacketId,
      });

    console.log(racketHistoryData);
    const userRacketId = racketHistoryData[0].t_user_racket_id;

    console.log(racketHistoryData[0].t_user_racket_id);
    const RacketInfoData = await db
      .select({
        racket_nickname: 'ru.racket_nickname',
        company_name: 'rc.name',
        racket_version_name: 'tv.name',
        model: 'tr.model',
        weight_ungut: 'tr.weight_ungut',
        racket_balance_lb_val: 'tr.racket_balance_lb_val',
        racket_balance_lb_type: 'tr.racket_balance_lb_type',
        main_tension: 'rp.main',
        cross_tension: 'rp.cross',
      })
      .from({ ru: tableNames.userRacket })
      .innerJoin({ tr: tableNames.racket }, 'tr.id', '=', 'ru.t_racket_id')
      .innerJoin(
        { tv: tableNames.racketVersion },
        'tv.id',
        '=',
        'tr.t_racket_version_id'
      )
      .innerJoin(
        { rc: tableNames.racketCompany },
        'rc.id',
        '=',
        'tr.t_racket_company_id'
      )
      .innerJoin(
        { rp: tableNames.racketPattern },
        'rp.id',
        '=',
        'tr.t_racket_pattern_id'
      )
      .where({
        'ru.id': userRacketId,
        'ru.t_user_id': reqParams.id,
      })
      .first();
    return { list: racketHistoryData, racket_info: RacketInfoData };
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
