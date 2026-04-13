const express = require('express');
const router = express.Router();

const authController = require('./auth');
const quizController = require('./quizz');
const verifyToken = require('./middlewares/authMiddleware');

router.post('/auth/register', authController.register);
router.post('/auth/login', authController.login);
router.post('/auth/refresh', authController.refresh);
router.post('/auth/google', authController.googleLogin);

router.post('/auth/logout', verifyToken, authController.logout);

router.post('/quizzes', verifyToken, quizController.createQuiz);
router.get('/quizzes', verifyToken, quizController.getQuizzes);
router.get('/history', verifyToken, quizController.getQuizHistory);
router.post('/history', verifyToken, quizController.saveQuizHistory);
router.get('/categories', verifyToken, quizController.getCategories);

module.exports = router;