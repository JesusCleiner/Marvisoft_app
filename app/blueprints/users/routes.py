from flask import render_template, redirect, url_for
from . import users_bp
# from .forms import LoginForm, RegisterForm  # Se usarán cuando agregues login real

@users_bp.route('/login')
def login():
    # Temporal: solo muestra el template
    return render_template('users/login.html')

@users_bp.route('/register')
def register():
    return render_template('users/register.html')

@users_bp.route('/profile')
def profile():
    return render_template('users/profile.html')
