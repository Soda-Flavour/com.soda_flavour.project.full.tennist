const db = require('../../../db');
const tableNames = require('../../../constants/tableNames');

module.exports = {
  async getRacketOfAllUserData() {
    const result = await db
      .select({
        user_id: 'user.id',
        user_nick: 'user.nick',
        user_thumb: 'user.thumb',
        racket_model: 'ra.model',
        racket_cnt: db.raw('(select count(ur_c.id) from t_user_racket ur_c where ur_c.t_user_id = user.id)')
      })
      .from({
        ur: tableNames.userRacket
      })
      .innerJoin({
        user: tableNames.user
      }, 'user.id', '=', 'ur.t_user_id')
      .innerJoin({
        ra: tableNames.racketData
      }, 'ra.id', '=', 'ur.t_racket_id')
      .where(
        'ur.created_at',
        '=',
        db.raw(' (select max(`urr`.`created_at`) from `t_user_racket` as `urr` where `urr`.`t_user_id` = `ur`.`t_user_id`)')
      )
      .orderBy('ur.updated_at', 'desc');
    return result;

  },

};