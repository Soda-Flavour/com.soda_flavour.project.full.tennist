const db = require('../../db');

const tableNames = require('../../constants/tableNames');
const {
  where
} = require('../../db');



module.exports = {

  async insertUserThumb(reqParams) {
    return db(tableNames.user).where({
      id: reqParams.id
    }).update('thumb', reqParams.fileName);
  },
  async getMyPageData(reqParams) {
    return db
      .select(
        'user.nick', {
          ntrp: 'up.ntrp',
          play_style: 'ps.name'

        }
      )
      .from({
        user: tableNames.user
      })
      // .leftJoin({
      //   tr: tableNames.racket
      // }, 'tr.id', '=', 'ru.t_racket_id')
      .innerJoin({
          up: tableNames.userPhysical
        },
        'up.t_user_id',
        '=',
        'user.id'
      )
      .innerJoin({
          ps: tableNames.playStyle
        },
        'ps.id',
        '=',
        'up.t_play_style_id'
      )
      .where({
        'user.id': reqParams.id
      }).first();
  },

};