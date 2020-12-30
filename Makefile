NAME=libasm.a
SRCS =	ft_strlen.s \
		ft_strcpy.s \
		ft_strcmp.s \
		ft_strdup.s \
		ft_write.s \
		ft_read.s 
SRCSB =	ft_atoi_base_bonus.s 
OBJS = $(SRCS:.s=.o)
OBJSB = $(SRCSB:.s=.o)

LINK = ld -lSystem
NASMFLAGS = -f macho64

$(NAME): all
all: $(OBJS)
	ar rcs $(NAME) $(OBJS)
%.o: %.s
	nasm $(NASMFLAGS) -o $@ $<
bonus: $(OBJS) $(OBJSB)
	ar rcs $(NAME) $(OBJS) $(OBJSB)
clean:
	rm -f $(OBJS)
	rm -f $(OBJSB)
fclean: clean
	rm -f $(NAME)
	rm -f a.out
re: fclean all
test: bonus
	gcc main.c libasm.a
.PHONY: all clean fclean re test