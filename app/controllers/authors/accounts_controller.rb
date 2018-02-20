module Authors
  class AccountsController < AuthorController
    def edit
    end

    def update_info
      # email must be formatted correctly
      # name is required on update
      if current_author.update(author_info_params)
        flash[:success] = 'Successfully saved info'
      else
        flash[:warning] = current_author.display_error_messages
      end
      redirect_to authors_account_path
    end

    def change_password
      # original password is wrong
      # password or confirmation is blank
      # password or confirmation don't match
      author = current_author
      if author.valid_password?(author_password_params[:current_password])
        if author.change_password(author_password_params)

        sign_in(author, bypass: true) #bypass: true bec. divise automatically signs out 23min part 13
        flash[:success] = 'Successfully changed password'
      else
        flash[:danger] = author.display_error_messages
      end
      else
        flash[:danger] = 'Current password is incorrect'
      end
      redirect_to authors_account_path
    end

    def author_info_params
      params.require(:author).permit(:name, :email, :bio)
    end

    def author_password_params
      params.require(:author).permit(:current_password, :new_password, :new_password_confirmation)
    end
  end
end
