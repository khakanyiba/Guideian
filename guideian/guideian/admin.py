from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User, Course

# Register the custom User model with the UserAdmin
admin.site.register(User, UserAdmin)

# Register the Course model
admin.site.register(Course)