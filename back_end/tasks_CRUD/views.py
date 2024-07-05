import email

from django.http import Http404
from django.shortcuts import get_object_or_404
from rest_framework.response import Response
from .serializers import *
from rest_framework.decorators import api_view
from .models import *

@api_view(['POST'])
def create_note(request,email):
    data=request.data
    user=CustomUser.objects.get(email=email)
    task=Task.objects.create(
        email=user,
        date=data["date"],
        time=data["time"],
        task_to_do=data["task_to_do"],
    )
    serializer=task_serializer(task,many=False)
    return Response(serializer.data)

@api_view(['GET'])
def get_tasks(request,email):
    tasks=Task.objects.filter(email__email=email)
    s=task_serializer(tasks,many=True)
    return Response(s.data)


@api_view(['PUT'])
def update_task(request,pk):
    data = request.data
    note = get_object_or_404(Task, id=pk)
    serializer = task_serializer(note, data=data,partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors)

@api_view(['DELETE','GET'])
def deleteTask(request, pk):
    try:
        note = Task.objects.get(id=pk)
        note.delete()
        return Response({"message": "Note was deleted"})
    except Http404:
        return Response({"error": "Task not found"}, status=404)
# Create your views here.
