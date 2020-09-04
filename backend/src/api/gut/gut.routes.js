const express = require('express');
const apiError = require('../../lib/apiError');
const queries = require('./gut.queryies');
const { orWhereNotExists } = require('../../db');

const router = express.Router();

router.get('/list_with_company', async (req, res) => {
  try {
    const gut_companies = await queries.listWithCompany();
    res.json({
      result: {
        status: 200,
        message: 'send data..',
        data: { list: gut_companies },
      },
    });
  } catch (error) {
    console.log(error);
    if (error.errorCode == undefined) {
      error = await apiError('E3800');
    }
    next(error);
  }
});

router.get('/companies', async (req, res) => {
  try {
    console.log('vkvkvkvk');
    const gut_companies = await queries.gutCompanies();
    res.json({
      result: {
        status: 200,
        message: 'send data..',
        data: { list: gut_companies },
      },
    });
  } catch (error) {
    console.log(error);
    if (error.errorCode == undefined) {
      error = await apiError('E3800');
    }
    next(error);
  }
});

router.get('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const gut_list = await queries.gutList(id);
    res.json({
      result: {
        status: 200,
        message: 'send data..',
        data: { list: gut_list },
      },
    });
  } catch (error) {
    console.log(error);
    if (error.errorCode == undefined) {
      error = await apiError('E3800');
    }
    next(error);
  }
});

router.get('/companies/:id', async (req, res, next) => {
  const { id } = req.params;
  try {
    if (isNaN(id)) {
      const error = new Error('Invalid ID');
      res.status(422);
      throw error;
    } else {
      const gut_company = await queries.comapanyGutList(parseInt(id, 10) || 0);
      if (!gut_company) {
        const err = await apiError('E3710');
        res.status(403);
        throw err;
      }

      res.json({
        result: {
          status: 200,
          message: 'send data..',
          data: { gut_company },
        },
      });
    }
  } catch (error) {
    console.log(error);
    if (error.errorCode == undefined) {
      error = await apiError('E3700');
    }
    next(error);
  }
});

module.exports = router;
