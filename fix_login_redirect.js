/**
 * 修复问卷完成后跳转到登录页面的问题
 * 
 * 这个脚本解决了以下问题：
 * 1. 当用户完成问卷后，即使未登录也应该进入应用主页（访客模式）
 * 2. 确保问卷完成状态被正确保存
 */

// 在页面加载完成后检查问卷完成状态
document.addEventListener('DOMContentLoaded', function() {
  console.log('修复脚本已加载');
  
  // 延迟执行以确保原始脚本已加载
  setTimeout(function() {
    const quizCompleted = localStorage.getItem('quizCompleted');
    const isLoggedIn = localStorage.getItem('isLoggedIn') === 'true';
    const guestMode = localStorage.getItem('guestMode') === 'true';
    
    console.log('问卷状态:', quizCompleted, '登录状态:', isLoggedIn, '访客模式:', guestMode);
    
    // 如果问卷已完成但未设置访客模式或登录，则设置访客模式
    if (quizCompleted === 'true' && !isLoggedIn && !guestMode) {
      console.log('设置访客模式');
      localStorage.setItem('guestMode', 'true');
      
      // 尝试重新初始化应用
      if (typeof App !== 'undefined' && App.init) {
        console.log('重新初始化应用');
        App.init();
      }
    }
  }, 500);
  
  // 修改QuizScreen.completeQuiz方法以确保设置访客模式
  if (typeof QuizScreen !== 'undefined' && QuizScreen.completeQuiz) {
    const originalCompleteQuiz = QuizScreen.completeQuiz;
    
    QuizScreen.completeQuiz = function(responses) {
      console.log('增强版completeQuiz方法被调用');
      
      // 调用原始方法
      originalCompleteQuiz.call(this, responses);
      
      // 保存用户偏好
      localStorage.setItem('quizCompleted', 'true');
      
      // 如果用户未登录，则设置访客模式
      if (!CloudStorage.currentUser) {
        console.log('问卷完成后设置访客模式');
        localStorage.setItem('guestMode', 'true');
      }
      
      // 确保App重新初始化以反映新状态
      setTimeout(function() {
        if (typeof App !== 'undefined' && App.init) {
          App.init();
        }
      }, 100);
    };
    
    console.log('QuizScreen.completeQuiz方法已增强');
  }
}); 