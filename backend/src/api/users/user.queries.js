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
        'user.nick',
      )
      .from({
        user: tableNames.user
      })
      .leftJoin({
        tr: tableNames.racket
      }, 'tr.id', '=', 'ru.t_racket_id')
      // .innerJoin({
      //     rv: tableNames.racketVersion
      //   },
      //   'rv.id',
      //   '=',
      //   'tr.t_racket_version_id'
      // )
      .where({
        'user.id': reqParams.id
      });
  },

};