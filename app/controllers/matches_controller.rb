class MatchesController < ApplicationController
  def index
  end

  def incoming
    @current_student = Student.find_by(email: session[:student_id])

    @pending_requests_A = Match.where(student1_email: @current_student, relationship_enum: 2)
    @pending_requests_B = Match.where(student2_email: @current_student, relationship_enum: 1)
    
    @pending_emails = Student.where(email: @pending_requests_A.pluck(:student2_email)).or(Student.where(email: @pending_requests_B.pluck(:student1_email)))
  end

  def pending
    @current_student = Student.find_by(email: session[:student_id])

    @pending_requests_A = Match.where(student1_email: @current_student, relationship_enum: 1)
    @pending_requests_B = Match.where(student2_email: @current_student, relationship_enum: 2)
    
    @pending_emails = Student.where(email: @pending_requests_A.pluck(:student2_email)).or(Student.where(email: @pending_requests_B.pluck(:student1_email)))    

  end

  def show
  end

  def matched
    @current_student = Student.find_by(email: session[:student_id])

    @existing_matches_A = Match.where(student1_email: @current_student, relationship_enum: 3)
    @existing_matches_B = Match.where(student2_email: @current_student, relationship_enum: 3)

    #@existing_matches_A = Match.where(student1_email: @current_student, relationship_enum: 0)
    
    @matched_emails = Student.where(email: @existing_matches_A&.pluck(:student2_email)).or(Student.where(email: @existing_matches_B&.pluck(:student1_email)))  
   

  end

  def blocked
    @current_student = Student.find_by(email: session[:student_id])

    @existing_blocks_A = Match.where(student1_email: @current_student, relationship_enum: -1)
    @existing_blocks_B = Match.where(student2_email: @current_student, relationship_enum: -2)
    @existing_blocks_C = Match.where(student1_email: @current_student, relationship_enum: -3)
    @existing_blocks_D = Match.where(student2_email: @current_student, relationship_enum: -3)
    
    @blocked_emails = Student.where(email: @existing_blocks_A.pluck(:student2_email)).or(Student.where(email: @existing_blocks_B.pluck(:student1_email))).or(Student.where(email: @existing_blocks_C.pluck(:student1_email))).or(Student.where(email: @existing_blocks_D.pluck(:student1_email)))    
    
  end

  def update
    @match = Match.find(params[:id])
    student_email = session[:student_id]
    if student_email != @match.student1_email && student_email != @match.student2_email
      render :edit, status: :unprocessable_entity
    end
    action_name = params[:action_name]
    if action_name == 'block'
      if @match.student1_email == student_email && @match.relationship_enum >= 0
        @match.relationship_enum = -1
      elsif @match.student2_email == student_email  && @match.relationship_enum >= 0
        @match.relationship_enum = -2
      elsif (@match.student1_email == student_email && @match.relationship_enum == -2) || (@match.student2_email == student_email && @match.relationship_enum == -1)
        @match.relationship_enum = -3
      end
    end
    if action_name == 'unblock'
      if @match.student1_email == student_email && @match.relationship_enum == -3 
        @match.relationship_enum = -2
      elsif @match.student2_email == student_email && @match.relationship_enum == -3 
        @match.relationship_enum = -1
      elsif @match.student1_email == student_email && @match.relationship_enum == -1
        @match.relationship_enum = 0
      elsif @match.student2_email == student_email && @match.relationship_enum == -2
        @match.relationship_enum = 0
      end
    end
    if action_name == 'send_match_request'
      if @match.student1_email == student_email && @match.relationship_enum == 0
        @match.relationship_enum = 1
      elsif @match.student2_email == student_email && @match.relationship_enum == 0
        @match.relationship_enum = 2
      end
    end
    if action_name == 'cancel_match_request'
      if @match.student1_email == student_email && @match.relationship_enum == 1
        @match.relationship_enum = 0
      elsif @match.student2_email == student_email && @match.relationship_enum == 2
        @match.relationship_enum = 0
      end
    end
    if action_name == 'accept_match_request'
      if @match.student1_email == student_email && @match.relationship_enum == 2
        @match.relationship_enum = 3
      elsif @match.student2_email == student_email && @match.relationship_enum == 1
        @match.relationship_enum = 3
      end
    end
    if action_name == 'reject_match_request'
      if @match.student1_email == student_email && @match.relationship_enum == 2
        @match.relationship_enum = 0
      elsif @match.student2_email == student_email && @match.relationship_enum == 1
        @match.relationship_enum = 0
      end
    end
    if action_name == 'unmatch'
      if @match.student1_email == student_email && @match.relationship_enum == 3
        @match.relationship_enum = 0
      elsif @match.student2_email == student_email && @match.relationship_enum == 3
        @match.relationship_enum = 0
      end
    end
    if @match.save
      if @match.student1_email == student_email
        redirect_to student_path(@match.student2_email)
      else 
        redirect_to student_path(@match.student1_email)
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def match_params
    params.require(:match).permit(:student1_email, :student2_email, :match_score, :relationship_enum) 
  end
end


