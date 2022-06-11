class BulkDiscountsController < ApplicationController

def index
end

def show
end

def new
end

def update
end

def edit
end

def create
end

def destroy
end

private


def discount_params
  params.permit(:percent, :threshold)
end
end