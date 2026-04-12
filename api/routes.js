const express = require('express');
const router = express.Router();

const authController = require('./auth');
const quizController = require('./quiz');

router.post('/auth/register', authController.register);
router.post('/auth/login', authController.login);
router.post('/auth/refresh', authController.refresh);
router.post('/auth/google', authController.googleLogin);

router.post('/auth/logout', authController.logout);

router.post('/quizzes', quizController.createQuiz);
router.get('/quizzes', quizController.getQuizzes);
router.get('/history', quizController.getQuizHistory);
router.post('/history', quizController.getQuizHistory);
router.get('/categories', quizController.getCategories);


module.exports = router;