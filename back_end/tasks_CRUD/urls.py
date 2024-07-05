from django.urls import path
from .views import *

urlpatterns = [
    path('<str:email>-create_task/',create_note),
    path('<str:email>-get_tasks/',get_tasks),
    path('<int:pk>-update_task/',update_task),
    path('<int:pk>-delete_task/',deleteTask),
]