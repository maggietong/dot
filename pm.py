##
## TODO: find a general, clean way to do PM without modifying the file under test. This is the general, ugly way of
## doing it:
##

def thing():
    1/0

if __name__ == '__main__':
    try:
        thing()
    except:
        from pudb import post_mortem
        post_mortem()
